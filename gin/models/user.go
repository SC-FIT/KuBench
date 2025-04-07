package models

type User struct {
	ID            int            `gorm:"column:id;primaryKey;autoIncrement;default:nextval('user_id_seq')"`
	GroupID       int            `gorm:"column:group_id;not null"` // Foreign key for Group
	Group         Group          `gorm:"foreignKey:GroupID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`
	StateID       int            `gorm:"column:state_id;not null"` // Foreign key for Usergroupstate
	State         Usergroupstate `gorm:"foreignKey:StateID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL"`
	Name          string         `gorm:"column:name;not null"`
	Surname       string         `gorm:"column:surname;not null"`
	Login         string         `gorm:"column:login;not null"`
	Passwd        *string        `gorm:"column:passwd"` // Pointer for nullable
	Email         string         `gorm:"column:email;not null"`
	Phone         *string        `gorm:"column:phone"` // Pointer for nullable
	IsDsmAdmin    bool           `gorm:"column:is_dsm_admin;not null;default:false"`
	IsGroupAdmin  bool           `gorm:"column:is_group_admin;not null;default:false"`
	IsPlanner     bool           `gorm:"column:is_planner;not null;default:false"`
	IsSupportTech bool           `gorm:"column:is_support_tech;not null;default:false"`
	Photo         *string        `gorm:"column:photo"` // Pointer for nullable
}

// TableName overrides the default table name for GORM
func (User) TableName() string {
	return "\"user\""
}
