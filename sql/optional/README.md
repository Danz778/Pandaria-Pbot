# Optional world database repairs

These scripts change quest, NPC, or script behavior and must be run manually.
Keep this directory outside the database updater's `updates_include` paths.

Before running a script, back up the world database, read the script, and check
that its tables and columns match your schema. From the repository root:

```sh
mysqldump -u USER -p world > world_backup.sql
mysql -u USER -p world < sql/optional/world/02_perbaikan_opsional.sql
```

Stop and resolve any error before retrying. Restart `worldserver` afterward and
check the new `DBErrors.log`.
