package repositories

import (
	"errors"
	"experiment/models"
	"gorm.io/gorm"
)

type UsergroupstateRepository struct {
	Db *gorm.DB
}

func (t UsergroupstateRepository) FindAll() (usergroupstates []models.Usergroupstate, err error) {
	results := t.Db.Find(&usergroupstates)
	if results.Error != nil {
		return nil, results.Error
	}

	return usergroupstates, nil
}

func (t UsergroupstateRepository) FindById(usergroupstateId int) (usergroupstate models.Usergroupstate, err error) {
	result := t.Db.Find(&usergroupstate, usergroupstateId)

	if result.Error != nil {
		return models.Usergroupstate{}, result.Error
	}

	if result.RowsAffected == 0 {
		return models.Usergroupstate{}, errors.New("Usergroupstate is not found")
	}

	return usergroupstate, nil
}

func (t *UsergroupstateRepository) Save(usergroupstate models.Usergroupstate) error {
	result := t.Db.Save(&usergroupstate)
	if result.Error != nil {
		return result.Error
	}

	return nil
}
