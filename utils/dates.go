package utils

import "time"

func ParseDateQueryParam(date string) (time.Time, error) {
	return time.Parse("2006-01-02", date)
}
