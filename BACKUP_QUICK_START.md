# 🚀 Daily Backup System - Quick Start

## ✅ System Ready!

Your CRM now has automated daily backup and restore capabilities.

---

## 🎯 Quick Setup (5 Minutes)

### Step 1: Run Setup Script

```powershell
.\setup-daily-backup.ps1
```

This will:
- ✅ Create backup directory
- ✅ Test backup command
- ✅ Guide you through Task Scheduler setup
- ✅ Create test backup

### Step 2: Configure Task Scheduler

1. Open **Task Scheduler** (Windows + R, type `taskschd.msc`)
2. Click **"Create Basic Task"**
3. Fill in:
   - **Name:** CRM Daily Backup
   - **Trigger:** Daily at 2:00 AM
   - **Action:** Start a program
     - **Program:** `php`
     - **Arguments:** `artisan backup:daily --retention=30`
     - **Start in:** `D:\Leads copy\LeadMS` (your project path)
4. Click **Finish**

### Step 3: Test the System

```bash
# Create manual backup
php artisan backup:daily

# Access admin panel
# http://127.0.0.1:8000/admin/backup-restore
```

---

## 💻 Manual Commands

```bash
# Create backup (30-day retention)
php artisan backup:daily

# Create backup (60-day retention)
php artisan backup:daily --retention=60

# List backups
dir storage\app\backups

# Check logs
type storage\logs\laravel.log | findstr backup
```

---

## 🌐 Admin Panel

**URL:** `http://127.0.0.1:8000/admin/backup-restore`

**Features:**
- ✅ View all backups
- ✅ Create manual backups
- ✅ Download backups
- ✅ Restore from backup
- ✅ Delete old backups
- ✅ Real-time statistics

**Access:** Admin users only

---

## 📊 What Gets Backed Up

### Database
- All leads and contacts
- User accounts
- Follow-ups and reminders
- Communications
- Analytics data

### Files
- Storage directory
- Uploaded files
- Configuration (.env)

### Metadata
- Backup timestamp
- Database size
- Lead count
- System version

---

## 🔄 Backup Schedule

**Automated:**
- Daily at 2:00 AM
- 30-day retention (automatic cleanup)
- Compressed ZIP format

**Manual:**
- Anytime via admin panel
- Anytime via command line

---

## 📁 Backup Location

```
storage/app/backups/
```

**File Format:**
```
backup_2024-12-16_14-30-25.zip
```

---

## 🛡️ Security Tips

1. **Store Offsite**
   - Copy backups to external drive
   - Upload to cloud storage

2. **Test Regularly**
   - Test restore monthly
   - Verify data integrity

3. **Before Changes**
   - Always backup before updates
   - Keep pre-change backups

---

## 🚨 Quick Troubleshooting

### Backup Fails
```bash
# Check permissions
icacls storage\app\backups

# Create directory
mkdir storage\app\backups

# Test command
php artisan backup:daily
```

### Can't Access Admin Panel
- Login as admin user
- Check role in database
- Clear cache: `php artisan cache:clear`

### Scheduled Backup Not Running
- Check Task Scheduler is enabled
- Verify task settings
- Test command manually

---

## 📚 Full Documentation

See **BACKUP_SYSTEM_GUIDE.md** for:
- Detailed configuration
- Advanced features
- Troubleshooting guide
- Best practices
- Security recommendations

---

## ✅ Verification Checklist

- [ ] Run setup script
- [ ] Configure Task Scheduler
- [ ] Create test backup
- [ ] Access admin panel
- [ ] Download a backup
- [ ] Test restore process
- [ ] Set up offsite storage

---

## 🎉 You're All Set!

Your CRM data is now protected with:
- ✅ Automated daily backups
- ✅ Easy restore process
- ✅ Web-based management
- ✅ 30-day retention
- ✅ Comprehensive logging

**Access the admin panel to get started!**

`http://127.0.0.1:8000/admin/backup-restore`
