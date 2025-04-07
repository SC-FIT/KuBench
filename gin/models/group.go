package models

import (
	"time"
)

type Group struct {
	ID                     int            `gorm:"column:id;primaryKey;autoIncrement;default:nextval('group_id_seq')"`
	Name                   string         `gorm:"column:name;not null"`
	ContractSigned         time.Time      `gorm:"column:contract_signed;not null"`
	ContractNumber         *int           `gorm:"column:contract_number"` // Pointer for nullable
	InstituteName          *string        `gorm:"column:institute_name"`  // Pointer for nullable
	InstituteAddressName   string         `gorm:"column:institute_address_name;not null"`
	InstituteAddressNumber *string        `gorm:"column:institute_address_number"` // Pointer for nullable
	InstitutePostalCode    string         `gorm:"column:institute_postal_code;not null"`
	Province               *string        `gorm:"column:province"` // Pointer for nullable
	City                   string         `gorm:"column:city;not null"`
	Country                string         `gorm:"column:country;not null"`
	VAT                    *string        `gorm:"column:vat"` // Pointer for nullable
	InstitutePhone         string         `gorm:"column:institute_phone;not null"`
	InstituteEmail         string         `gorm:"column:institute_email;not null"`
	StateID                int            `gorm:"column:state_id;not null"` // Foreign key
	State                  Usergroupstate `gorm:"foreignKey:StateID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`
	Priority               float64        `gorm:"column:priority;not null"`
	ResponsibleUserID      *int           `gorm:"column:responsible_user_id"` // Foreign key
	ResponsibleUser        *User          `gorm:"foreignKey:ResponsibleUserID"`
}

// TableName overrides the default table name for GORM
func (Group) TableName() string {
	return "\"group\""
}
