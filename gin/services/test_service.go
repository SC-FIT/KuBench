package services

import (
	"archive/zip"
	"encoding/csv"
	"errors"
	"experiment/models"
	"experiment/repositories"
	"io"
	"os"
	"path/filepath"
	"strconv"
	"time"
)

type TestService struct {
	//Repo 				   repositories.
	UserRepository           *repositories.UserRepository
	GroupRepository          *repositories.GroupRepository
	UsergroupstateRepository *repositories.UsergroupstateRepository
	TempFiles                map[string]string
}

//func NewTestService(repo *repositories.repositories) *TestService {
//	return &TestService{
//		Repo:      repo,
//		TempFiles: make(map[string]string),
//	}
//}

func (fs *TestService) HandleFileUpload(filePath string) error {
	err := fs.OpenZipFile(filePath)
	if err != nil {
		return err
	}
	return fs.ImportFromFile()
}

func (fs *TestService) OpenZipFile(file string) error {
	fs.TempFiles = make(map[string]string)
	r, err := zip.OpenReader(file)
	if err != nil {
		return err
	}
	defer r.Close()

	for _, file := range r.File {
		if filepath.Ext(file.Name) == ".csv" {
			outFile, err := os.CreateTemp("", file.Name)
			if err != nil {
				return err
			}
			fs.TempFiles[file.Name] = outFile.Name()
			src, _ := file.Open()
			defer src.Close()
			_, err = io.Copy(outFile, src)
			if err != nil {
				return err
			}
		}
	}
	return nil
}

func (fs *TestService) ImportFromFile() error {
	err := fs.insertGroupState()
	if err != nil {
		return err
	}
	err = fs.insertGroup()
	if err != nil {
		return err
	}
	return fs.insertUser()
}

func (fs *TestService) insertGroupState() error {
	filePath, exists := fs.TempFiles["usergroupstate.csv"]
	if !exists {
		return errors.New("usergroupstate not found")
	}
	file, err := os.Open(filePath)
	if err != nil {
		return err
	}
	defer file.Close()

	reader := csv.NewReader(file)
	_, _ = reader.Read()
	for {
		line, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}
		id, _ := strconv.Atoi(line[0])
		state := models.Usergroupstate{ID: id, Label: line[1]}
		fs.UsergroupstateRepository.Save(state)
	}
	return nil
}

func (fs *TestService) insertGroup() error {
	filePath, exists := fs.TempFiles["group.csv"]
	if !exists {
		return errors.New("group not found")
	}
	file, err := os.Open(filePath)
	if err != nil {
		return err
	}
	defer file.Close()

	reader := csv.NewReader(file)
	_, err = reader.Read() // skip header
	if err != nil {
		return err
	}

	for {
		line, err := reader.Read()
		if err != nil {
			break
		}

		groupID, _ := strconv.Atoi(line[0])
		contractSigned, _ := time.Parse("2006-01-02 15:04:05.000", line[2])
		contractNumber, _ := strconv.Atoi(line[3])
		priority, _ := strconv.ParseFloat(line[16], 64)

		stateID, _ := strconv.Atoi(line[14])
		state, err := fs.UsergroupstateRepository.FindById(stateID)
		if err != nil {
			return err
		}

		group := models.Group{
			ID:                     groupID,
			Name:                   line[1],
			ContractSigned:         contractSigned,
			ContractNumber:         &contractNumber,
			InstituteName:          &line[4],
			InstituteAddressName:   line[5],
			InstituteAddressNumber: &line[6],
			InstitutePostalCode:    line[7],
			Province:               &line[8],
			City:                   line[9],
			Country:                line[10],
			VAT:                    &line[11],
			InstitutePhone:         line[12],
			InstituteEmail:         line[13],
			State:                  state,
			Priority:               priority,
		}

		err = fs.GroupRepository.Save(group)
		if err != nil {
			return err
		}
	}
	return nil
}

func (fs *TestService) insertUser() error {
	filePath, exists := fs.TempFiles["user.csv"]
	if !exists {
		return errors.New("user not found")
	}
	file, err := os.Open(filePath)
	if err != nil {
		return err
	}
	defer file.Close()
	reader := csv.NewReader(file)
	_, err = reader.Read() // skip header
	if err != nil {
		return err
	}

	for {
		line, err := reader.Read()
		if err != nil {
			break
		}

		userID, _ := strconv.Atoi(line[0])
		groupID, _ := strconv.Atoi(line[1])
		stateID, _ := strconv.Atoi(line[2])
		isDsmAdmin, _ := strconv.ParseBool(line[9])
		isGroupAdmin, _ := strconv.ParseBool(line[10])
		isPlanner, _ := strconv.ParseBool(line[11])
		isSupportTech, _ := strconv.ParseBool(line[12])

		group, err := fs.GroupRepository.FindById(groupID)
		if err != nil {
			return err
		}

		state, err := fs.UsergroupstateRepository.FindById(stateID)
		if err != nil {
			return err
		}

		user := models.User{
			ID:            userID,
			Group:         group,
			State:         state,
			Name:          line[3],
			Surname:       line[4],
			Login:         line[5],
			Passwd:        &line[6],
			Email:         line[7],
			Phone:         &line[8],
			IsDsmAdmin:    isDsmAdmin,
			IsGroupAdmin:  isGroupAdmin,
			IsPlanner:     isPlanner,
			IsSupportTech: isSupportTech,
			Photo:         &line[13],
		}

		err = fs.UserRepository.Save(user)
		if err != nil {
			return err
		}
	}
	return nil
}

func openFile(fs *TestService, tableName string) (*os.File, error) {

	return nil, nil
}
