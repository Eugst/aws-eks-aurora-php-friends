<?php 

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require __DIR__ . '/vendor/autoload.php';
$user_id = 13;
$friend_id = 82;
$handshake_limit = 4;
$options = [];
echo "check friendship from uid $user_id to uid $friend_id with handshake limit $handshake_limit <br>";

use Medoo\Medoo;

function get_friends($uid) {
    $database = new Medoo([
        'database_type' => 'mysql',
        'database_name' => 'eugene_test',
        'server' => getenv('DB_HOST'),
        'username' => getenv('DB_USER'),
        'password' => getenv('DB_PWD')
    ]);
    return  $database->select('facebook_friends', 'friend_id', ['user_id' => $uid]);
}

function find_path($uid, $fid, $handshakes=0, $result=array(), $exclude=array()) {
    global $handshake_limit, $options;
    $handshakes++;
    array_push($result, $uid);
    $friends = array_diff(get_friends($uid), $exclude);
    if (count($friends) > 0) { 
        if (in_array($fid, $friends)) {
            array_push($result, $fid);
            $options[] = $result;
        } elseif ($handshakes < $handshake_limit) {
            foreach($friends as $friend_id) {
                $next_path = find_path(
                    $friend_id, 
                    $fid, 
                    $handshakes, 
                    $result, 
                    array_unique(array_merge($exclude, [$uid], $friends))
                );
                if (is_array($next_path) && in_array($fid, $next_path)) {
                    $options[] = $next_path;
                }
            }
        }
    }
    return [];
}


$r = find_path($user_id, $friend_id);
usort($options, function ($a, $b) {
    $a = count($a);
    $b = count($b);
    return ($a == $b) ? 0 : (($a < $b) ? -1 : 1);
});
var_dump($options[0]);
