<?php 
// =======================================================================================
// Automatically generated parameter file
// =======================================================================================
$paramDbType = getenv('DB_TYPE') ?: 'pgsql';
$paramDbHost = getenv('DB_HOST') ?: 'db';
$paramDbPort = getenv('DB_PORT') ?: '5432';
$paramDbUser = getenv('DB_USER') ?: 'projeqtor';
$paramDbPassword = getenv('DB_PASSWORD') ?: 'projeqtor';
$paramDbName = getenv('DB_NAME') ?: 'projeqtor';
$paramDbDisplayName = getenv('DB_DISPLAY_NAME') ?: 'ProjeQtOr';
$paramDbPrefix = getenv('DB_PREFIX') ?: '';
$SslKey = '';
$SslCert = '';
$SslCa = '';
$paramLdap_allow_login = 'false';
$paramLdap_base_dn = 'dc=mydomain,dc=com';
$paramLdap_host = 'localhost';
$paramLdap_port = '389';
$paramLdap_version = '3';
$paramLdap_search_user = 'cn=Manager,dc=mydomain,dc=com';
$paramLdap_search_pass = 'secret';
$paramLdap_user_filter = 'uid=%USERNAME%';
$paramMailSmtpServer = 'localhost';
$paramMailSmtpPort = '25';
$paramMailSendmailPath = '';
$paramPasswordMinLength = '5';
$paramDefaultLocale = 'fr';
$paramDefaultTimezone = 'Europe/Paris';
$currency = '€';
$currencyPosition = 'after';
$paramAttachmentDirectory = '/opt/projeqtor/files/attach/';
$documentRoot = '/opt/projeqtor/files/documents/';
$paramAttachmentMaxSize = '10485760';
$AttachmentMaxSizeMail = '2097152';
$paramReportTempDirectory = '/opt/projeqtor/files/report/';
$paramMemoryLimitForPDF = '512';
$logFile = '/opt/projeqtor/files/logs/projeqtor_${date}.log';
$logLevel = '2';
