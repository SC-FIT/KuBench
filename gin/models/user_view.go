package models

type UserView struct {
	UserID           int     `gorm:"column:user_id"`
	GroupName        string  `gorm:"column:group_name"`
	ContractNumber   *int    `gorm:"column:contract_number"`
	InstituteName    string  `gorm:"column:institute_name"`
	InstituteAddress string  `gorm:"column:institute_address_name"`
	City             string  `gorm:"column:city"`
	Name             string  `gorm:"column:name"`
	Surname          string  `gorm:"column:surname"`
	Login            string  `gorm:"column:login"`
	Email            string  `gorm:"column:email"`
	Phone            *string `gorm:"column:phone"`
	StatusName       string  `gorm:"column:status_name"`
	IsDsmAdmin       bool    `gorm:"column:is_dsm_admin"`
	IsGroupAdmin     bool    `gorm:"column:is_group_admin"`
	IsPlanner        bool    `gorm:"column:is_planner"`
	IsSupportTech    bool    `gorm:"column:is_support_tech"`
	Photo            *string `gorm:"column:photo"`
}
