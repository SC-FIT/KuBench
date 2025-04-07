package repositories

import (
	"errors"
	"experiment/models"
	"gorm.io/gorm"
)

type UserRepository struct {
	Db *gorm.DB
}

func (t UserRepository) FindAll() (users []models.User, err error) {
	results := t.Db.Find(&users)
	if results.Error != nil {
		return nil, results.Error
	}

	return users, nil
}

func (t UserRepository) FindById(userId int) (user models.User, err error) {
	result := t.Db.Find(&user, userId)

	if result.Error != nil {
		return models.User{}, result.Error
	}

	if result.RowsAffected == 0 {
		return models.User{}, errors.New("User is not found")
	}

	return user, nil
}

func (t *UserRepository) Save(user models.User) error {
	result := t.Db.Save(&user)
	if result.Error != nil {
		return result.Error
	}

	return nil
}

func (t *UserRepository) ComplexSelectTest() ([]models.UserView, error) {
	var results []models.UserView
	query := `
        SELECT u.id AS user_id,
               g.name AS group_name,
               g.contract_number,
               g.institute_name,
               g.institute_address_name,
               g.city,
               u.name,
               u.surname,
               u.login,
               u.email,
               u.phone,
               s.label AS status_name,
               u.is_dsm_admin,
               u.is_group_admin,
               u.is_planner,
               u.is_support_tech,
               u.photo
        FROM public."user" u
        JOIN public.usergroupstate s ON u.state_id = s.id
        JOIN public."group" g ON u.group_id = g.id
    `
	if err := t.Db.Raw(query).Scan(&results).Error; err != nil {
		return nil, err
	}
	return results, nil
}
