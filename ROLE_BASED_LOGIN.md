# Role-Based Login System

## Overview
The system now supports separate login functionality for Admin and Sales Executive users with role-based access control.

## User Roles

### 1. Admin
- **Email**: admin@ulms.com
- **Password**: admin123
- **Role**: admin
- **Access**: Full system access

### 2. Sales Executive
- **Email**: sales@ulms.com
- **Password**: sales123
- **Role**: sales_executive
- **Access**: Limited to sales-related features

## Setup Instructions

### 1. Run the Seeder
Create the test users by running:
```bash
php artisan db:seed --class=RoleUsersSeeder
```

### 2. Login Process
1. Navigate to `/login`
2. Enter credentials for either Admin or Sales Executive
3. System will automatically redirect based on role
4. Success message will display role-specific welcome

## Implementation Details

### Authentication Flow
1. User enters credentials on login page
2. System validates credentials
3. If valid, checks user role
4. Redirects to appropriate dashboard with role-specific message
5. Session stores user role for access control

### Role Checking Methods

#### In Controllers
```php
// Check if user is admin
if (auth()->user()->isAdmin()) {
    // Admin-only code
}

// Check if user is sales executive
if (auth()->user()->isSalesExecutive()) {
    // Sales executive code
}

// Check specific role
if (auth()->user()->hasRole('admin')) {
    // Role-specific code
}
```

#### In Blade Views
```blade
@if(auth()->user()->isAdmin())
    <!-- Admin-only content -->
@endif

@if(auth()->user()->isSalesExecutive())
    <!-- Sales executive content -->
@endif
```

### Route Protection

#### Protect routes for specific roles:
```php
// Admin only
Route::middleware(['auth', 'role:admin'])->group(function () {
    Route::get('/admin/users', [UserController::class, 'index']);
});

// Sales Executive only
Route::middleware(['auth', 'role:sales_executive'])->group(function () {
    Route::get('/sales/leads', [LeadController::class, 'index']);
});

// Multiple roles
Route::middleware(['auth', 'role:admin,sales_executive'])->group(function () {
    Route::get('/reports', [ReportController::class, 'index']);
});
```

## Features

### ✓ Implemented
- Separate login credentials for Admin and Sales Executive
- Role-based authentication
- Role checking helper methods in User model
- Custom middleware for route protection
- Welcome messages based on role
- Test users seeder

### 🔄 Recommended Enhancements
- Create separate dashboards for each role
- Implement role-specific sidebar menus
- Add permission-based feature access
- Create role management interface for admins
- Add activity logging per role
- Implement role-based notifications

## Security Notes

1. **Password Security**: Change default passwords in production
2. **Role Validation**: Always validate user roles on server-side
3. **Session Management**: Sessions are regenerated on login for security
4. **Access Control**: Use middleware to protect sensitive routes
5. **Database**: Ensure 'role' column exists in users table

## Testing

### Test Admin Login
1. Go to `/login`
2. Email: admin@ulms.com
3. Password: admin123
4. Should see: "Welcome back, Admin!"

### Test Sales Executive Login
1. Go to `/login`
2. Email: sales@ulms.com
3. Password: sales123
4. Should see: "Welcome back, Sales Executive!"

## Troubleshooting

### Issue: "Column 'role' not found"
**Solution**: Run migration to add role column:
```bash
php artisan make:migration add_role_to_users_table
```

### Issue: Users not created
**Solution**: Run the seeder:
```bash
php artisan db:seed --class=RoleUsersSeeder
```

### Issue: 403 Unauthorized
**Solution**: Check if user has correct role assigned in database

## Database Schema

### Users Table
```sql
- id (bigint)
- name (varchar)
- email (varchar, unique)
- password (varchar)
- role (varchar) -- 'admin', 'sales_executive', etc.
- remember_token (varchar)
- created_at (timestamp)
- updated_at (timestamp)
```

## Role-Specific Dashboards

### Admin Dashboard (Dual View)
**Admin users can toggle between two views:**

#### 1. Admin View
**View**: `resources/views/dashboard/admin.blade.php`
**URL**: `/dashboard?view=admin` (default)

**Features**:
- Full system overview
- All leads across all users
- Team performance metrics
- System-wide analytics
- User management access
- Complete lead source breakdown
- Geographic distribution
- AI insights for all leads

#### 2. Sales Team View
**View**: `resources/views/dashboard/admin-sales-view.blade.php`
**URL**: `/dashboard?view=sales`

**Features**:
- Overview of all sales executives
- Individual performance cards for each sales executive
- Total leads per sales executive
- Conversions per sales executive
- Conversion rate per sales executive
- Performance badges (Excellent/Good/Average)
- Quick comparison of team members

**Toggle**: Admin can switch between views using the toggle buttons at the top

### Sales Executive Dashboard
**View**: `resources/views/dashboard/sales-executive.blade.php`

**Features**:
- Personal performance metrics ONLY
- Only their assigned leads
- Individual conversion rate
- Personal monthly performance chart
- Recent leads assigned to them
- Pending follow-ups for their leads
- This month's conversions
- Personalized welcome message

**Access**: Sales Executive users only (NO toggle - they only see their own data)
**Restriction**: Cannot view other sales executives' data

### Dashboard Routing Logic
The `DashboardController` automatically routes users to their appropriate dashboard:

```php
public function index()
{
    $user = auth()->user();
    
    if ($user->isAdmin()) {
        return $this->adminDashboard();
    } elseif ($user->isSalesExecutive()) {
        return $this->salesExecutiveDashboard();
    }
    
    return $this->defaultDashboard();
}
```

## Next Steps

1. Run the seeder to create test users:
   ```bash
   php artisan db:seed --class=RoleUsersSeeder
   ```

2. Test Admin login:
   - Email: admin@ulms.com
   - Password: admin123
   - Should see: Full system dashboard with all leads

3. Test Sales Executive login:
   - Email: sales@ulms.com
   - Password: sales123
   - Should see: Personal dashboard with only their leads

4. Customize dashboards further based on needs
5. Add more role-specific features
6. Create role management interface

---

**Created**: December 2024
**Updated**: December 2024
**System**: Lead Management System (ULMS)
