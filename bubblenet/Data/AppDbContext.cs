using Microsoft.EntityFrameworkCore;

namespace AppDotNet.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<Orders>? Orders { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
            => options.UseSqlite("DataSource=app.db;Cache=Shared");
    }
}
