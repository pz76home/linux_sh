# Use IFS to have awk handle complex file names correctly
IFS=$'\n'

# Create directory tree first using parallel utility to run multiple processes
parallel --will-cite -j 20 /usr/bin/rsync -dirs --existing --ignore-existing --delete -e ssh /nas/ root@remotesys:/mnt/nas/ > /admin/working/rsync.log

# Replicate files from working list "/admin/working/list.migrated"
awk '{print substr($0, index($0,$5)) }' </admin/working/list.migrated |  parallel --will-cite -j 20 /usr/bin/rsync --relative -av -e ssh {} root@remotesys:/mnt/ >> /admin/working/rsync.log

rc=$?

if [ $rc -ne '0' ]
then
/usr/bin/mail -s "Daily Spectrum Scale to DR rsync failed" -c sysadmin@work.com someone@work.com < /admin/scripts/rsync_mail
else
echo "Daily rsync successful" >> /admin/working/rsync.log
fi


## Example of /admin/working/list.migrated data

4106 1703504793 0   --  /nas/Data/Archive/databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/27/04/580BC5E3/722952BD/50BABB7B/E4EB
4107 1795892670 0   --  /nas/Data/Archive/databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/29/07/A1B623F5/50113268/03F15C9E/2881
4108 352973628 0   --  /nas/Data/Archive/databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/29/9D/A99344DB/5418A85E/F2CA633B/E7C7
4109 134954531 0   --  /nas/Data/Archive/databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/2C/BA/4C6874BF/D5AA71C6/64E07302/13FB
4110 2023092853 0   --  /nas/Data/Archive/databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/2F/D4/12C10B1C/92AB9B41/A28DCD23/B2E5
4111 85853686 0   --  /nas/Data/Archive/ databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/30/C0/5835D063/8E263C79/6865B3FA/AD31
4112 396830690 0   --  /nas/Data/Archive/ databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/32/3F/FC84FC8C/457D961D/0F990BB5/3C22
4113 1739131195 0   --  /nas/Data/Archive/ databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/33/B8/CB3B99A4/D1817CA9/9A26AEDC/58BF
4114 2002274391 0   --  /nas/Data/Archive/ databaseDR/Progressive/IncrementalBackup_2015-10-09_0039/Databases/RC_Data_FMS/Data-new System Test-4/Files/Secure/37/4C/BF8FB7F4/A6DE4B8C/69488AF1/E239
