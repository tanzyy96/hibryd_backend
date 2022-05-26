package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"hibryd_backend/graph/generated"
	"hibryd_backend/graph/model"
	"time"

	"github.com/google/uuid"
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
	user := model.User{
		ID:        id.String(),
		Username:  input.Username,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
		Birthdate: input.Birthdate,
		JoinedAt:  input.JoinedAt,
		CompanyID: input.CompanyID,
	}
	if result := r.DB.Create(&user); result.Error != nil {
		return nil, result.Error
	}
	return &user, nil
}

func (r *queryResolver) User(ctx context.Context, id string) (*model.User, error) {
	panic(fmt.Errorf("not implemented"))
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
