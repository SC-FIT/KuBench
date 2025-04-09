namespace experiment.Models;

public class UserView
{
    public int UserId { get; set; } 
    public string GroupName { get; set; }
    public int ContractNumber { get; set; } 
    public string InstituteName { get; set; }
    public string InstituteAddressName { get; set; }
    public string City { get; set; } 
    public string UserName { get; set; }
    public string UserSurname { get; set; }
    public string UserLogin { get; set; } 
    public string UserEmail { get; set; } 
    public string UserPhone { get; set; }
    public string StatusName { get; set; }
    public bool IsDsmAdmin { get; set; } 
    public bool IsGroupAdmin { get; set; }
    public bool IsPlanner { get; set; } 
    public bool IsSupportTech { get; set; } 
    public string? Photo { get; set; }
    
    
}