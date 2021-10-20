using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace AppDotNet.Migrations
{
    public partial class InitialCreation : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "TEXT", nullable: false),
                    StoreNumber = table.Column<int>(type: "INTEGER", nullable: false),
                    OrderNumber = table.Column<int>(type: "INTEGER", nullable: false),
                    OrderDatetime = table.Column<DateTime>(type: "TEXT", nullable: false),
                    Flavour = table.Column<string>(type: "TEXT", nullable: false),
                    Toppings = table.Column<string>(type: "TEXT", nullable: false),
                    AmmountOfIce = table.Column<string>(type: "TEXT", nullable: false),
                    TotalOrderPrice = table.Column<double>(type: "REAL", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Orders");
        }
    }
}
