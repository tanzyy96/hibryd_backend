package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"hibryd_backend/graph/generated"
	"hibryd_backend/graph/model"
	"hibryd_backend/utils"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func (r *mutationResolver) CreateCompany(ctx context.Context, input model.NewCompany) (*model.Company, error) {
	company := model.Company{
		Name: input.Name,
	}
	if result := r.DB.Create(&company); result.Error != nil {
		return nil, result.Error
	}
	return &company, nil
}

func (r *mutationResolver) CreateUser(ctx context.Context, input model.NewUser) (*model.User, error) {
	id := uuid.New()
	bdate, err1 := utils.ParseDateQueryParam(input.Birthdate)
	joined_at, err2 := utils.ParseDateQueryParam(input.JoinedAt)
	if err1 != nil || err2 != nil {
		return nil, &model.ErrorResponse{
			Message: "invalid date format",
			Err:     err1.Error(),
		}
	}
	user := model.User{
		ID:        id.String(),
		Username:  input.Username,
		LastName:  input.LastName,
		FirstName: input.FirstName,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
		Birthdate: bdate,
		JoinedAt:  joined_at,
		CompanyID: input.CompanyID,
	}
	if result := r.DB.Create(&user); result.Error != nil {
		return nil, result.Error
	}
	return &user, nil
}

func (r *mutationResolver) CreateDayTasks(ctx context.Context, input model.NewDayTasks) ([]*model.Task, error) {
	var tasks []*model.Task
	date, err := utils.ParseDateQueryParam(input.Datetime)
	if err != nil {
		return nil, &model.ErrorResponse{
			Message: "invalid date format",
			Err:     err.Error(),
		}
	}
	dayTasks := model.DayTasks{
		UserID:   input.UserID,
		Datetime: date,
	}

	// Transaction so that if we fail to create tasks, we don't create dayTasks
	err = r.DB.Transaction(func(tx *gorm.DB) error {
		if result := r.DB.Create(&dayTasks); result.Error != nil {
			return result.Error
		}

		for _, newTask := range input.Tasks {
			task := model.Task{
				DaytasksID:  dayTasks.ID,
				Description: newTask.Description,
				Status:      newTask.Status,
			}
			tasks = append(tasks, &task)
		}

		if result := r.DB.Create(&tasks); result.Error != nil {
			return result.Error
		}

		return nil
	})

	return tasks, err
}

func (r *mutationResolver) CreateWeekTasks(ctx context.Context, input model.NewWeekTasks) ([]*model.DayTasks, error) {
	panic(fmt.Errorf("not implemented"))
}

func (r *mutationResolver) CreateWeekStatus(ctx context.Context, input model.NewWeekStatus) ([]*model.DayStatus, error) {
	var statuses []*model.DayStatus
	start, err1 := utils.ParseDateQueryParam(input.StartDate)
	end, err2 := utils.ParseDateQueryParam(input.EndDate)
	if err1 != nil || err2 != nil {
		return nil, &model.ErrorResponse{
			Message: "invalid date format",
		}
	}
	weekStatus := model.WeekStatus{
		UserID:    input.UserID,
		StartDate: start,
		EndDate:   end,
	}

	// Transaction so that if we fail to create statuses, we don't create weekStatus
	err := r.DB.Transaction(func(tx *gorm.DB) error {
		if result := r.DB.Create(&weekStatus); result.Error != nil {
			return result.Error
		}

		for _, newStatus := range input.Statuses {
			date := weekStatus.StartDate.AddDate(0, 0, newStatus.DayIndex)
			status := model.DayStatus{
				WeekStatusID: weekStatus.ID,
				DayIndex:     newStatus.DayIndex,
				Date:         date,
				Status:       &newStatus.Status,
			}
			statuses = append(statuses, &status)
		}

		if result := r.DB.Create(&statuses); result.Error != nil {
			return result.Error
		}

		return nil
	})

	return statuses, err
}

func (r *mutationResolver) UpdateDayTasks(ctx context.Context, input model.UpdateDayTasks) ([]*model.Task, error) {
	var tasks []*model.Task
	err := r.DB.Transaction(func(tx *gorm.DB) error {
		for _, updateTask := range input.Tasks {
			task := model.Task{}
			if err := r.DB.Model(&task).
				Clauses(clause.Returning{}).
				Where("daytasks_id = ?", input.ID).
				Where("id = ?", updateTask.ID).
				Update("description", updateTask.Description).Error; err != nil {
				return err
			}
			tasks = append(tasks, &task)
		}
		return nil
	})
	return tasks, err
}

func (r *mutationResolver) UpdateTask(ctx context.Context, input model.UpdateTask) (*model.Task, error) {
	task := model.Task{}
	err := r.DB.Model(&task).
		Clauses(clause.Returning{}).
		Where("id = ?", input.ID).
		Update("description", model.Task{
			Description: *input.Description,
			Status:      input.Status,
		}).Error

	return &task, err
}

func (r *mutationResolver) UpdateDayStatus(ctx context.Context, input model.UpdateDayStatus) (*model.DayStatus, error) {
	dayStatus := model.DayStatus{}
	err := r.DB.Model(&dayStatus).
		Clauses(clause.Returning{}).
		Where("id = ?", input.ID).
		Update("status", input.Status).Error

	return &dayStatus, err
}

func (r *mutationResolver) UpdateWeekStatus(ctx context.Context, input model.UpdateWeekStatus) ([]*model.DayStatus, error) {
	var statuses []*model.DayStatus
	err := r.DB.Transaction(func(tx *gorm.DB) error {
		for _, updateStatus := range input.Statuses {
			status := model.DayStatus{}
			if err := r.DB.Model(&status).
				Clauses(clause.Returning{}).
				Where("id = ?", updateStatus.ID).
				Update("status", updateStatus.Status).Error; err != nil {
				return err
			}
			statuses = append(statuses, &status)
		}
		return nil
	})
	return statuses, err
}

func (r *queryResolver) User(ctx context.Context, id string) (*model.User, error) {
	var user model.User
	if result := r.DB.First(&user, id); result.Error != nil {
		return nil, result.Error
	}
	return &user, nil
}

func (r *queryResolver) Users(ctx context.Context) ([]*model.User, error) {
	var users []*model.User
	if result := r.DB.Find(&users); result.Error != nil {
		return nil, result.Error
	}
	return users, nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
