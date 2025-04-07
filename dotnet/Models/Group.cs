using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace experiment.Models;

[Table("\"group\"")] // Double quotes for case-sensitive table name
public class Group
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("id")]
    public int Id { get; set; }

    [Required]
    [Column("name")]
    [MaxLength(int.MaxValue)]
    public string? Name { get; set; }

    [Required] [Column("contract_signed")] 
    public DateTime ContractSigned { get; set; }

    [Column("contract_number")] 
    public int? ContractNumber { get; set; }

    [Column("institute_name")]
    [MaxLength(int.MaxValue)]
    public string? InstituteName { get; set; }

    [Required]
    [Column("institute_address_name")]
    [MaxLength(int.MaxValue)]
    public string? InstituteAddressName { get; set; }

    [Column("institute_address_number")]
    [MaxLength(int.MaxValue)]
    public string? InstituteAddressNumber { get; set; }

    [Required]
    [Column("institute_postal_code")]
    [MaxLength(int.MaxValue)]
    public string? InstitutePostalCode { get; set; }

    [Column("province")]
    [MaxLength(int.MaxValue)]
    public string? Province { get; set; }

    [Required]
    [Column("city")]
    [MaxLength(int.MaxValue)]
    public string? City { get; set; }

    [Required]
    [Column("country")]
    [MaxLength(int.MaxValue)]
    public string? Country { get; set; }

    [Column("vat")]
    [MaxLength(int.MaxValue)]
    public string? Vat { get; set; }

    [Required]
    [Column("institute_phone")]
    [MaxLength(int.MaxValue)]
    public string? InstitutePhone { get; set; }

    [Required]
    [Column("institute_email")]
    [MaxLength(int.MaxValue)]
    public string? InstituteEmail { get; set; }

    [Required] [ForeignKey("StateId")] public Usergroupstate? State { get; set; }
    [Column("state_id")] public int StateId { get; set; }

    [Required] [Column("priority")] public float Priority { get; set; } // Use float for Float

    [ForeignKey("ResponsibleUserId")] public User ResponsibleUser { get; set; }
    [Column("responsible_user_id")] public int? ResponsibleUserId { get; set; } // Nullable int
}