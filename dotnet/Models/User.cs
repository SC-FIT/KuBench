using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace experiment.Models;

[Table("\"user\"")] // Use double quotes for case-sensitive table names
public class User
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)] // Handles nextval
    [Column("id")]
    public int Id { get; set; }

    [Required]
    [ForeignKey("GroupId")] // Explicitly define foreign key property
    public Group? Group { get; set; }

    [Column("group_id")] public int GroupId { get; set; }

    [Required]
    [ForeignKey("StateId")] // Explicitly define foreign key property
    public Usergroupstate? State { get; set; }

    [Column("state_id")] public int StateId { get; set; }

    [Required]
    [Column("name")]
    [MaxLength(int.MaxValue)]
    public string? Name { get; set; }

    [Required]
    [Column("surname")]
    [MaxLength(int.MaxValue)]
    public string? Surname { get; set; }

    [Required]
    [Column("login")]
    [MaxLength(int.MaxValue)]
    public string? Login { get; set; }

    [Column("passwd")]
    [MaxLength(int.MaxValue)]
    public string? Passwd { get; set; }

    [Required]
    [Column("email")]
    [MaxLength(int.MaxValue)]
    public string? Email { get; set; }

    [Column("phone")]
    [MaxLength(int.MaxValue)]
    public string? Phone { get; set; }

    [Required] [Column("is_dsm_admin")] public bool IsDsmAdmin { get; set; } = false; // Default value

    [Required] [Column("is_group_admin")] public bool IsGroupAdmin { get; set; } = false; // Default value

    [Required] [Column("is_planner")] public bool IsPlanner { get; set; } = false; // Default value

    [Required] [Column("is_support_tech")] public bool IsSupportTech { get; set; } = false; // Default value

    [Column("photo")]
    [MaxLength(int.MaxValue)]
    public string? Photo { get; set; }
}