# PowerShell script to add reminder features to notes-comments page

$file = "resources/views/Communication/notes-comments.blade.php"
$content = Get-Content $file -Raw

# Add reminder styles to the CSS
$reminderStyles = @"
        
        /* Reminder Styles */
        .reminder-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .reminder-badge.active {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-color: rgba(239, 68, 68, 0.3);
            animation: pulse-reminder 2s infinite;
        }

        @keyframes pulse-reminder {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }

        .reminder-notification {
            position: fixed;
            top: 80px;
            right: 20px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            border-left: 4px solid var(--warning);
            max-width: 400px;
            z-index: 1000;
            display: none;
            animation: slideInRight 0.3s ease-out;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .reminder-notification.show {
            display: block;
        }

        .reminder-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-weight: 700;
            color: var(--warning);
        }

        .reminder-body {
            color: var(--dark);
            margin-bottom: 15px;
        }

        .reminder-actions {
            display: flex;
            gap: 10px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 10px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .checkbox-group label {
            cursor: pointer;
            user-select: none;
        }
"@

# Insert reminder styles before closing </style>
$content = $content -replace '</style>', "$reminderStyles`n    </style>"

# Save the file
Set-Content -Path $file -Value $content -NoNewline

Write-Output "Reminder styles added successfully!"
Write-Output "File updated: $file"
