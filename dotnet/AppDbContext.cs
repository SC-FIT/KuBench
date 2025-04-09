using experiment.Models;
using Microsoft.EntityFrameworkCore;

namespace experiment;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }
    
    public DbSet<Usergroupstate> Usergroupstates { get; set; }
    public DbSet<Group> Groups { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<UserView> UserViews { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Usergroupstate>().ToTable("usergroupstate");
        modelBuilder.Entity<Group>().ToTable("group");
        modelBuilder.Entity<User>().ToTable("user");
        modelBuilder.Entity<UserView>().HasNoKey();
    }
}