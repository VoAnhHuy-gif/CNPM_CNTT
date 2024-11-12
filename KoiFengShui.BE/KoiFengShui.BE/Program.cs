using FengShuiKoi_Repository;
using FengShuiKoi_Services;
using KoiFengShui.BE.Middleware;
using KoiFengShui.BE.TokenService;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace KoiFengShui.BE
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            // Configure JWT
                       // Configure JWT
            var jwtSigningKey = Environment.GetEnvironmentVariable("JWT_SIGNING_KEY") ?? "YourTestSigningKey";
            var jwtIssuer = Environment.GetEnvironmentVariable("JWT_ISSUER") ?? "TestIssuer";
            var jwtAudience = Environment.GetEnvironmentVariable("JWT_AUDIENCE") ?? "TestAudience";

            if (string.IsNullOrEmpty(jwtSigningKey) || string.IsNullOrEmpty(jwtIssuer) || string.IsNullOrEmpty(jwtAudience))
            {
                throw new InvalidOperationException("JWT configuration is missing in environment variables");
            }

            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = jwtIssuer,
                        ValidAudience = jwtAudience,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSigningKey))
                    };
                });
         
            // Register services
            builder.Services.AddScoped<IAccountService, AccountService>();
            builder.Services.AddScoped<IMemberService, MemberService>();
            builder.Services.AddScoped<IToken, Token>();
            builder.Services.AddScoped<IElementService, ElementService>();
            builder.Services.AddScoped<IKoiVarietyService, KoiVarietyService>();
            builder.Services.AddScoped<IQuantityOfFishService, QuantityOfFishService>();
            builder.Services.AddScoped<IPointOfShapeService, PointOfShapeService>();
            builder.Services.AddScoped<IShapeService, ShapeService>();
            builder.Services.AddScoped<LunarCalendarConverter>();
            builder.Services.AddScoped<ILifePlaceDirectionService, LifePlaceDirectionService>();
            builder.Services.AddScoped<ILifePlaceService, LifePlaceService>();
            builder.Services.AddScoped<IDirectionService, DirectionService>();
            builder.Services.AddScoped<IColorService, ColorService>();
            builder.Services.AddScoped<IAdsPackageService, AdsPackageService>();
            builder.Services.AddScoped<ITypeColorService, TypeColorService>();
            builder.Services.AddScoped<IElementColorService, ElementColorService>();
            builder.Services.AddScoped<IBlogService, BlogService>();
            builder.Services.AddScoped<IElementService, ElementService>();
            builder.Services.AddScoped<IKoiVarietyService, KoiVarietyService>();
            builder.Services.AddScoped<IQuantityOfFishService, QuantityOfFishService>();
            builder.Services.AddScoped<IPackageService, PackageService>();
            builder.Services.AddScoped<IAdvertisementService, AdvertisementService>();

            builder.Services.AddScoped<IFeedbackService, FeedbackService>();

            builder.Services.AddHostedService<AdvertisementExpirationService>();



            builder.Services.AddHostedService<AdvertisementExpirationService>();
            builder.Services.AddSingleton<IVerificationCodeService, VerificationCodeService>();
            builder.Services.AddSingleton<IEmailService, EmailService>();
            builder.Services.AddSingleton<IConfiguration>(builder.Configuration);
            // Add CORS
            builder.Services.AddCors(options =>

            {
                options.AddPolicy("AllowReactApp",
                    builder => builder.WithOrigins("http://localhost:5173")
                                      .AllowAnyMethod()
                                      .AllowAnyHeader());
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            
            app.UseHttpsRedirection();

            app.UseAuthentication();
            app.UseAuthorization();
            app.UseCors("AllowReactApp");
            app.UseMiddleware<JwtMiddleware>();
            app.MapControllers();

            app.Run();
        }
    }
}
