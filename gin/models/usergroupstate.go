package models

type Usergroupstate struct {
	ID    int    `gorm:"column:id;primaryKey;autoIncrement;default:nextval('usergroupstate_id_seq')"`
	Label string `gorm:"column:label;not null"`
}

func (Usergroupstate) TableName() string {
	return "usergroupstate"
}
