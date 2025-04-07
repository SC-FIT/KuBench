using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace experiment.Models;

[Table("usergroupstate")]
public class Usergroupstate
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("id")]
    public int Id { get; set; }

    [Required]
    [Column("label")]
    [MaxLength(int.MaxValue)]
    public string? Label { get; set; }
}