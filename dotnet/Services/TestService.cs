using System.Globalization;
using System.IO.Compression;
using experiment.Models;
using CsvHelper;
using CsvHelper.Configuration;

namespace experiment.Services;

public class TestService
{
    private readonly AppDbContext _context;
    private readonly Dictionary<string, string> _tempFilesByOriginalFileName = new();

    public TestService(AppDbContext context)
    {
        _context = context;
    }

    public async Task HandleFileUploadAsync(IFormFile file)
    {
        OpenZipFile(file);
        await ImportFromFileAsync();
    }

    private async Task ImportFromFileAsync()
    {
        using var transaction = await _context.Database.BeginTransactionAsync();

        try
        {
            await InsertGroupStateAsync();
            await InsertGroupAsync();
            await InsertUserAsync();

            await transaction.CommitAsync();
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    private async Task InsertGroupStateAsync()
    {
        var filePath = GetTempFile("usergroupstate.csv");
        using var stream = new StreamReader(filePath);
        using var csvReader = BuildCsvReader(stream);

        // Skip the header row
        await csvReader.ReadAsync();
        csvReader.ReadHeader();

        while (await csvReader.ReadAsync())
        {
            var state = new Usergroupstate
            {
                Id = csvReader.GetField<int>("id"),
                Label = csvReader.GetField<string>("label")
            };

            var exists= await _context.Usergroupstates.FindAsync(state.Id);
            if (exists == null)
            {
                _context.Usergroupstates.Add(state);
            }
            await _context.SaveChangesAsync();
            _context.ChangeTracker.Clear();
        }
    }

    private async Task InsertGroupAsync()
    {
        var filePath = GetTempFile("group.csv");
        using var stream = new StreamReader(filePath);
        using var csvReader = BuildCsvReader(stream);

        // Skip the header row
        await csvReader.ReadAsync();
        csvReader.ReadHeader();

        while (await csvReader.ReadAsync())
        {
            var group = new Group
            {
                Id = csvReader.GetField<int>("id"),
                Name = csvReader.GetField<string>("name"),
                ContractSigned = DateTime.ParseExact(csvReader.GetField<string>("contract_signed") as string ?? string.Empty, 
                                                     "yyyy-MM-dd HH:mm:ss.ffffff", 
                                                     CultureInfo.InvariantCulture, 
                                                     DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                ContractNumber = csvReader.GetField<int>("contract_number"),
                InstituteName = csvReader.GetField<string>("institute_name"),
                InstituteAddressName = csvReader.GetField<string>("institute_address_name"),
                InstituteAddressNumber = csvReader.GetField<string>("institute_address_number"),
                InstitutePostalCode = csvReader.GetField<string>("institute_postal_code"),
                Province = csvReader.GetField<string>("province"),
                City = csvReader.GetField<string>("city"),
                Country = csvReader.GetField<string>("country"),
                Vat = csvReader.GetField<string>("vat"),
                InstitutePhone = csvReader.GetField<string>("institute_phone"),
                InstituteEmail = csvReader.GetField<string>("institute_email"),
                State = await _context.Usergroupstates.FindAsync(csvReader.GetField<int>("state_id")),
                Priority = csvReader.GetField<float>("priority")
            };

            var exists= await _context.Groups.FindAsync(group.Id);
            if (exists == null)
            {
                _context.Groups.Add(group);
            }
            await _context.SaveChangesAsync();
            _context.ChangeTracker.Clear();
        }
    }

    private async Task InsertUserAsync()
    {
        var filePath = GetTempFile("user.csv");
        using var stream = new StreamReader(filePath);
        using var csvReader = BuildCsvReader(stream);

        // Skip the header row
        await csvReader.ReadAsync();
        csvReader.ReadHeader();

        while (await csvReader.ReadAsync())
        {
            var user = new User
            {
                Id = csvReader.GetField<int>("id"),
                Group = await _context.Groups.FindAsync(csvReader.GetField<int>("group_id")),
                State = await _context.Usergroupstates.FindAsync(csvReader.GetField<int>("state_id")),
                Name = csvReader.GetField<string>("name"),
                Surname = csvReader.GetField<string>("surname"),
                Login = csvReader.GetField<string>("login"),
                Passwd = csvReader.GetField<string>("passwd"),
                Email = csvReader.GetField<string>("email"),
                Phone = csvReader.GetField<string>("phone"),
                IsDsmAdmin = csvReader.GetField<bool>("is_dsm_admin"),
                IsGroupAdmin = csvReader.GetField<bool>("is_group_admin"),
                IsPlanner = csvReader.GetField<bool>("is_planner"),
                IsSupportTech = csvReader.GetField<bool>("is_support_tech"),
                Photo = csvReader.GetField<string>("photo")
            };

            var exists= await _context.Users.FindAsync(user.Id);
            if (exists == null)
            {
                _context.Users.Add(user);
            }
            await _context.SaveChangesAsync();
            _context.ChangeTracker.Clear();
        }
    }

    private CsvReader BuildCsvReader(StreamReader reader)
    {
        var config = new CsvConfiguration(CultureInfo.InvariantCulture)
        {
            HasHeaderRecord = true
        };
        return new CsvReader(reader, config);
    }

    private void OpenZipFile(IFormFile file)
    {
        using var zipStream = new ZipArchive(file.OpenReadStream(), ZipArchiveMode.Read);

        foreach (var entry in zipStream.Entries)
        {
            if (!entry.FullName.EndsWith(".csv", StringComparison.OrdinalIgnoreCase)) continue;

            var tempFilePath = Path.GetTempFileName();
            _tempFilesByOriginalFileName[entry.FullName] = tempFilePath;

            using var entryStream = entry.Open();
            using var fileStream = new FileStream(tempFilePath, FileMode.Create, FileAccess.Write);

            entryStream.CopyTo(fileStream);
        }
    }

    private string GetTempFile(string fileName)
    {
        if (!_tempFilesByOriginalFileName.TryGetValue(fileName, out var tempFilePath))
            throw new FileNotFoundException($"Temporary file for '{fileName}' not found.");

        return tempFilePath;
    }
}