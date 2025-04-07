package repositories

import (
	"errors"
	"experiment/models"
	"gorm.io/gorm"
)

type GroupRepository struct {
	Db *gorm.DB
}

func (t GroupRepository) FindAll() (groups []models.Group, err error) {
	results := t.Db.Find(&groups)
	if results.Error != nil {
		return nil, results.Error
	}

	return groups, nil
}

func (t GroupRepository) FindById(groupId int) (group models.Group, err error) {
	result := t.Db.Find(&group, groupId)

	if result.Error != nil {
		return models.Group{}, result.Error
	}

	if result.RowsAffected == 0 {
		return models.Group{}, errors.New("Group is not found")
	}

	return group, nil
}

func (t *GroupRepository) Save(group models.Group) error {
	result := t.Db.Save(&group)
	if result.Error != nil {
		return result.Error
	}

	return nil
}
