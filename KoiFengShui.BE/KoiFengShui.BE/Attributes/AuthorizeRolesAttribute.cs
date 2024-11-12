using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;

namespace KoiFengShui.BE.Attributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true)]
    public class AuthorizeRolesAttribute : Attribute, IAuthorizationFilter
    {
        private readonly string[] _roles;

        public AuthorizeRolesAttribute(params string[] roles)
        {
            _roles = roles;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var userRole = context.HttpContext.Items["UserRole"]?.ToString();
            if (userRole == null || !_roles.Contains(userRole))
            {
                context.Result = new ForbidResult();
            }
            if (_roles != null && _roles.Length > 0)
            {
                if (userRole == null || !_roles.Contains(userRole))
                {
                    // Không có quyền truy cập
                    context.Result = new JsonResult(new { message = "Không có quyền truy cập" })
                    {
                        StatusCode = StatusCodes.Status403Forbidden
                    };
                }
            }
        }
    }
}