// # Ghost Configuration
// Setup your Ghost install for various environments
// Documentation can be found at http://support.ghost.org/config/

var path = require('path'),
	config;

config = {
	production: {
		url: 'http://%HOSTNAME%',
		mail: {
			transport: 'SMTP',
			options: {
				service: 'Gmail',
				auth: {
					user: '%GMAIL%',
					pass: '%GMAIL_PASSWORD%'
				}
			}
		},
		database: {
			client: 'pg',
				connection: {
					host     : '0.0.0.0',
					user     : 'postgres',
					password : '',
					database : 'ghost',
					charset  : 'utf8'
				}
		},
		server: {
			host: '0.0.0.0',
			port: '2368'
		}
	}
};

module.exports = config;
