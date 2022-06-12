package model

type ErrorResponse struct {
	Message string `json:"message"`
	Err     string `json:"error,omitempty"`
}

func (r *ErrorResponse) Error() string {
	return r.Message
}
