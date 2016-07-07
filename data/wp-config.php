<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'Wi3o5CIRqb');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'SwyVh;RGck;tGNT]o/3#xU%.&~1Ka]y1m~LdEcjrR!qO>eJE2Agk[Q^fyQP+NC@A');
define('SECURE_AUTH_KEY',  'zW>Tk/ME|w+]J}<A*zzLA?QeAlLIcc&7Dj3+W,BJq5#o@C`Nf:RL>i@x=XY(X7U9');
define('LOGGED_IN_KEY',    'j Faod/V{p+)I;<^>%C~x~,J_GId*vFznm,l,0iZ8C?!u{T>TZkH{.uKEE{_B1+B');
define('NONCE_KEY',        '>G;_upMOre*FHe{Jv!>%4A+ bR)SH*14p0<9VAaki#u :=FFJ.G~2V4NM1xFQJ}6');
define('AUTH_SALT',        '6%:diZLB`QB+,)6Pbt[P#i=Nb*9bTihfk.QBB:)-iQ~%G6FrXW;/xZ|NUdema9ra');
define('SECURE_AUTH_SALT', 'kC_Sg)pk$eL&+ 3ks2Eop+un{Mx:Ma]N_?>U]L(J_^<T+CZUTQ=yN:>Lu;p:5P^l');
define('LOGGED_IN_SALT',   '+{NRu p[nSi=n+Si&r{avqut*8$LI(:RHX_J`)$RN`oA/0<v:/M~p;lFi-&fM&Nc');
define('NONCE_SALT',       ']HI)91|z$N0YhRGio8T1pJPv(zd#?`z_,/{Dqlr?Ri[*/&ZQK,mFczMI-ki(s=ve');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
