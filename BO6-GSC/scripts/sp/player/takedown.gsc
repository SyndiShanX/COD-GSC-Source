/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\takedown.gsc
******************************************/

#using script_3798db193e76a866;
#using script_53f4e6352b0b2425;
#using script_758eb3e6844a19b3;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player;
#using scripts\sp\player\carrylinked;
#using scripts\sp\player_rig;
#using scripts\sp\stealth\player;
#using scripts\sp\utility;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace takedown;

function private autoexec __init__system__() {
  system::register(#"takedown", #"val", &pre_main, undefined);
}

function private pre_main() {
  if(!isDefined(level.player)) {
    level.player = getEntArray("K_p\x84a\x01", #classname)[0];
  }

  if(!isDefined(level.scripted_melee)) {
    level.scripted_melee = spawnStruct();
  }

  level.scripted_melee.disabled = 1;

  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  if(!isDefined(level.takedowns)) {
    setdvarifuninitialized(@ "hash_3ee9189d52e605f8", 0);

    setdvarifuninitialized(@ "hash_7cbf0b5da9c90d0e", 0);

    setdvarifuninitialized(@ "hash_c5a1703db7b78b53", "<dev string:x24>");

    setdvarifuninitialized(@ "hash_391d954ec12a55c3", 0);

    setdvarifuninitialized(@ "hash_be88768943ca7f16", 0);

    setdvarifuninitialized(@ "hash_a4c52236d240b4cd", 0);

    setdvarifuninitialized(@ "hash_378e249d52f4898f", 0);

    level.takedowns = spawnStruct();
    level.takedowns.takedowns = [];
    level.takedowns.callbackoverride = undefined;
    level.takedowns.maxrange = 0;
    level.takedowns.collisioncontents = physics_createcontents(["vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4", "Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);
    level.takedowns.collisioncontentsstand = physics_createcontents(["vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t"]);
    level.takedowns.var_9a71c163c51b754f = ["GX\xa9]\x82", "1x\xc5\xb4\xabx", "\x1d\xf5\x131\xf8", "\x05\xb1\x1c\x86\x11\xc7", "\xe7\x1aM\x85+z\x1b\x89\x0fU9", "\xac\x95\x19\x10S\x94uU\x8e\xc7", "\xa8&s\x87\x1b^\xb0\xff:", "\x9a\xe3\xe4\xff\x81%", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", "\xaf\xd7\xe5h\xeb+", "mV\x8d+e", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", "\x86X7\x8c\xdc", "\xe4\xf1G", "\xdfv\xca\x10\xffSH\xd00S#\x9d\x12;7\x17C'\xbb", "\xde\xfe\xb2", "\x9ct\n\x94\t\x10", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", "\xc1!\x88V\t\"DW\xfa\xac|\x1d\\", "\xbb\xca,8\xdbn\xf5\x9b\xdd-\x8ec\xd0\xd7c\xb1\x96\a", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe1P+\x1a \xe4\xd7-\xeel]", "\xcciN\xca", "\x1a\x9c\xb3\x11\xb5\xe0[6\xd6{8\x84", "\x1e\xfd\xd1\xa2\a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xf7~{\xb1\x14", "\xc9\xca\x1boX\x8c"];
    function_9ef9b4fe696f3de6();
    level.player function_4f919f20abb98492(1);
    level._effect["go\\R$z6\x18A\xf6^=\xd2(z~\xbf\xdb\xc46\x8fRsqsvfu\xa0\x18\xeb"] = loadfxasset("\x87\x96\xdcf28'y7\vQ\"\xf7\xcb\x88\af9\xb4\f7\xdf\xc5\xabTi\xd9w\x1f0\x8a\xd6\xa0\xfb]_\xc1\xe9\x15\xf6");
    level._effect["ji\x89\xe13p\x92\x01z\xa3\xf3\x9dm\xf4Qh\x02\xcf?\x03\xf7\xcc\xd5\x10\xc1p(g\xe2\x9c\xe8/\x82 \xa1"] = loadfxasset("m\xb7D\xbd\xbf\xe6\x18\xf5\xcb\xa3Q\xdd\x05\xa7\xf4\x95>\x14p\x03\x9eh\x82\xdeP[m>;\xcd\xa2\xe9\xf6\xea1\x1b\xaf\t\xdc\xb5*\n}#");
    level._effect["\xfbg\xcfQ\x11\ai\x97\xa7\x0e\x8c\x97qO\xf4\x90\x98\xf4\\\xee\xdd\x1c\t\x9fK\x13\x02\x10\x9a\x9fg\xfd]6*"] = loadfxasset("L\x86\x9e[9\x91` \x13\xf3\xdc\xde\xfb\xf7g\x8d)Bfc\xa5\xfd\x1fi\xcd\xf1Zz\x801Zj\x83\x0fe\xc33HM\xc4\xf4\x7f$\xe1");
    level._effect["\\\xc7\xec\xe5%\x9a\x99\x98\x11&f\xd7Q]\xd8>\xf1}\x15\xa4=\xf2\x87\x87?\t\x80\xf7\xb7YZ"] = loadfxasset("u\x02Di\xfe3\xee\xdd\x13\x84\b\xf1\xe4\xb9\\-}\x14\xea\x1a\xb6\xc5K\xc8\x14\a\x81e5\xe47\x01U\xf8\xb5`8?\n\x12");
    level._effect["\xc51\xf7\xc5\xd8q\x15^@\xf9\xf1\x98\x9c\xfa_\xc9K!J\x94Pu\x1d\xf9 S1\x80\xccIG\xf0S!K\xb4\xd8\x94\xccy\xb7\x1d\x12@"] = loadfxasset("\xac\xdd1\xe5E\xd7\xddh$Us\xf5\x1c\xbb\xb0o\xe3}\x04\r`nP\xd3!Y99\xd8\xf24\xadh\x1c\xbe\x04\x16\x9b>\xd2\xcb\x9d\x8e\xca(\xce\x87?\xac\xb0\xda@\x8e");
    level._effect["\xf7\x92\xd3\b\xac\x0e*\x7f\xbe\xadr\x8f\xa2\xbdj\x9f\xc8}\r`@\xa6\xd9\x8f{3\xc6p^<#"] = loadfxasset("\x122\x15\x18\x03\xdd\xa1U\xeb\xce\xe1\"\xa7\xef\xd1\xf0\\\x7f\t\x8c`\xd1\xf3H\x17n\xda\x9c\xa4\xde\x10\xef)th\xc2\x8f-<\xe8");
    level._effect["\x9d\x99\xc3\xfaY\x87Vc\xd7\x8dh\xc2\xad\xd6\x959}3r\xdbsG\xd7X\xeb\xc4l\xb7o\x19\xf5impX6\xe8"] = loadfxasset("\r\x86\xb3 fu4]a,\xac\x1e`U*\x9f\xbb\xda\xb6,\xcb\xfe\xa7\xb0\xb4\x7fo\xd4\xads\x9de\x93\t\x9e\xc6\xe0\xce\x85P\beK\xad$\xd3");
    level._effect["3\x0eJ\x8f\xba\x1c\xab\xe3\xe9\xbf\xfd\f\x01\xe8\n\xae\x8d\xd8\xb6;\x1bC\xfc\x88\x12\x83\xa4\xf3c\xfe\xe3f\xf4\xb8\x06\x91"] = loadfxasset("\xd6\x10u\xf3\xf7G\xef\xc8\x1c\xd0h\x15\xaf\xd0\xb1\xfb\xbd\xb1\x89`Ihd?\x90X\xee\xc2rT \xfd\xd1\x91\xa4\x11\xae\xfa\x96Z\xdfc\xfe\xe5\xf3");
    level._effect["\x9d3\xc3\xebY\xe1Vl\xf5\xb1hXm\xad+r\xfaf9\xb7s\xa3\xbeX\xf5w\xca\xb0\xc1\xde\xe6\xd7\xe8\x9c\xb0Z\x8d"] = loadfxasset("\xa1T\x05\xbd[\xc5\x99\xac\xd3\xa3^\xd9(Z\xb3\xe0c\x98\xe0'\x95\r\xfe\x8f\x947\xa6\xed\xfd(/\xa3\x9a#)\x86v*~\xb9\x80\xd2\x86%^(");
    level._effect["&\xc6\xfaK\xa4@o`B]\x80 q\xec\x84B/\x06\xfdc/\x1cYg@cu\xb0u\xed\xd4"] = loadfxasset("\xb3\xcc\x87\xaf\x8e\x890\xeb\xb1\xdb\x93Y}+\xe1\xac6\xfac\x1aXm\xda\xac\xc9_3No\xb9t\xf5\x13\xbe\xb4[\x0e,6G");
    level._effect["\v\xa8\xb5\f9\xdax.p\xab\x18\xbaZ\xd5\xb4,\x85\xafQ\x80\x85F\xd9\x15,\xdd\x98\x93\x81\x92#`\a\xc3\xf4\x90\xa9"] = loadfxasset("\x15\x1d1\xc0~\xd3]K\x1b\x9f\xacpo\x95\xfd9(\xa0\xab\xb9\xcbA\t\x8c\xca\x7f\xebbF\xeeuC\xc9'\xdf\x96\xf5h\xde'TYj\xd2\xa1\xf3");
    level._effect["\xa7\f\x88qH\xc0\x9f\xfe]\x9f\x91\xa1\xdab%R\"\xbc\xc0\xffj\xba\xfb\xce\xf5\xb9\xecD\xaf\xe2\x96\xa1T&\xb0\x96"] = loadfxasset("\xb2\x92\x98\x14\xb1]\xdb\xad*\xc0\x19\x97\\8]\xd0\x10\xb9\xf8\xba\x17\xe2@k\b\x96\x87q\x02Y\xd8\x8f0\xb9\xd9b\xd4\xb6\xb1,\xc8cS\x14\x1a");
    level._effect["\x17\xc2\xc0\x14\xbd\x14k\x1a\xbe>4\xff\xda\xef\xb5\xb5\v\xeeiHb\xf9T\xf5s\xf7p\f\xc7\x82\x03\xf4\xb0\xb5\x9e\x92\x17"] = loadfxasset("\xcef\x1e\xbe:\x98\x18\xaf\x1b\xf6'\xac\xafe\x87Y\x1b\xbe\xd8\x86\x16\xda\xb5\xac\x93}fN{\x9b\xd1\xbe\xc4\xafw\x95\x16\xe0\xf6n\xfat\x93\vil");
    level._effect["w\xf4\x1c\xfb\x92Y{\xf0\xbf\"\xd7)\xf6\x8e\x82\xe6\xa0f|\x04\x8d\x14\x7f:\xc3\xd9\xebX\xab\b\xfc\x0f\xf8\xc36\x1e("] = loadfxasset("x\xe6\x9e\x9e5\x96Cp`\xc1\xabf\xcf@\xa43\xa1\xbb\xa0\xd3\x99EdbD\xe1\x19\x8c\xd4\xc1d\x89b~:");
    level._effect["\xc4\xfe|\xafm8/\x04\xcf\xde8o\x9d,1\x04\xd7\xfa\x14\x91|g>\xcf\x94-\x18m\x93L"] = loadfxasset("Tv\xfcF\xd3\x142U\n{\xbc%U{K{#a\xcf\xc6C\xd4\x1b]|\x8aq\xda\xb1%\xb1\x7fx\x9d\x81\xfcW;\x1e");
    level._effect["\t|\xbaUy@\xdd:\x11\xfdF\x8c*\x19\xa0\x9dW\xe3x\x05\"O:W\\D\xe5\xd1\xc3\\\x0f\xb8\x88\x91\xda\xe5"] = loadfxasset("\x86\x87\xffc7Y&Zde\xaa\xa2+\xe7\xd8\xb5\xb3\xff\xe1\x1c\xa7UwnwaZ&M\xff<\xd1\xef\x01\xe1C.\x8cQ\rvz\x19\xa5`");
    level._effect["\xebe\v\x89\xad(\xad\x1ey\xf2\x90\x9f\xbb\xd3\xc8\xbaA\xeb?V\x93O\xf0\xe10\v\xc7\xcf\x871\f\xa5\x8b\xb2e"] = loadfxasset("v\x99\x0f\xeb\x1db0\xf5\xd8\xf69+\xbeV\x0f\x95l}c\x86,m\xadV\x9c\xeb\x93\xaca\x93\xd7,_16{o\x19_\xd1\xe4aK\x1b");
    level._effect["\x99\xf67\xe9\n!\xdd`I\xe8\x8af\xcdR\xeb#\x81,\r\xdf\xb5\xf4\xfe2\a\x9c\x9f\xe6\xdf\xa8\xf8z\xbdz\xc8\xca"] = loadfxasset("\xdcuA\xa0\xa5\xe0\x8e\xb2(A\xfbGB\x81H\xb5\xb7\xe5\x04\xa8\xf9\xe0\x10^\xe6\x1fk\xfc\xf9C\xbf\xe1\xff\x97#\xf2}\x8f\xe2\xd2\at\x9e\x9f]");
    level._effect["\xfe\x1c\x90\xd0\x99!T\xa3J!\xf1\x15\x94\xa6\xc2\x1f\xb7=X\x92u\xa6\x1d\xeca\xf4\x9dl`V\x96\xa3\xdd\xca\xae/\x03\xc3\x80\x05\xbd\xc2\b"] = loadfxasset("\xf5f\xa2\xe6q\xb6\x9e\x8a\x1a)\xf7\x94P5\xa8\f\xb0\xfcP\xb3@D\xb4\x84kP\xc2v<\x90\x902\xfa\xeb_\xc7\x0f\xa7\xcd\x11\xc7\x17[\t\xd6\x7f\x90@\x17 [\xe3");
    level._effect["W\x9a\xa1\xd0\xfe\xfa\xc5@\x01\xbf\xe3\x16\xecy\xc1V\xb4\xaf\\\xc4\x14/\x9d\xae6\xcc2\xa3a\x90\xdcU\x11y\xf0$\xd9\x97\xfaQ\xe6\x1cF\r"] = loadfxasset("\xa1\x9c\x19\xcb\xbb\x03\x8a\xeb\xab0\n\xda]\xe3\x9d\x9f\x7fY\xcb%\"\xb8 \xfdU\ahyF\xe7^Q+E\xbe\xd3<\x91.\xbdD\xf3\xac\x0f1;\x94\xe3\xa9\xa5g>c");
    level._effect["v\x99\x87\xf5\xac\xe1+\x1b_n\xe8\x8d\x8eh\xf5[si\xcc+\xbe\x9c\x95\xb0\xe4_\x8d\xd71c\xf6\xdb\x19\xeb\x9b\xac\x1b[\xebGN\x16Zl"] = loadfxasset("PG\xe3\x91\xf2<}b\xd4\x92\xde\x8a\x85}\x8f\xbb\x9e\xc3q\x11\x12\xa7\xa6\x8fC!\xf2\x8b\xe1<MfleP48\x8eX\x03,V\xf1\xb9\x01\x18\xf6\x9fs\xa4k\x0f6");
    level._effect["\x9f\x8b\x03`tN\x8a\xc1\xf77\xb2\x9b\xdf#\xe1\x87[\xd9\xea\xd3\xf1\xb1\x02\x1c\x9aJ4\xbdD\xfc\"\vv\x03\xbcVK\x19\x05<\xbf4w\x14m\x86"] = loadfxasset("\xedj\x04\x15\xda\x17N\xa5\x94\b\x1d\xea2\x87#\xb3m\xe9\x16d\x1f]\a\x85\x86\x10ml\xa7Nk\x15|UIq\xce\a\xd1=\x90\xa8\xa2\xfe\xc1\x02e<\xb3\xfec\x91\xce\x1d\x18");
    level._effect["\x9f\x9b6\xf7\xdd\x88\xe1\xb9\xfdq\x8e\xcc\x81\xbfT0\x90\xe5\xb8\x83\xa8\xbd\xc1\xb9\x9bp5\xa9\xad=\xd7Y\xd5V<\xa3\xd1\x11\xf0\xf88i\x14\xd0\xe1"] = loadfxasset("\x1a;\x95\x94\xb9Q;\xa2\xb8J \xf5\x9bnx\xa0\xc0\x0f\xf6\b\xecf^d\xf7\xc2Wm:$x\xb9A\xba\x1b\x93\xe0\x17\xd3(\xed\xd7UU\x7f\xde\xffd\xec\xf2\xe4\x1eB\xcc");
    level._effect["3\x0eJ\x8f\xba\x1c\xab\xe3\xe9?\xfa8\"\xc0~\xca\xc19\xa2k\x83\x01H\x8f4Ah\xf4{\x7f/\xa0\x80\x18\x1d\x95\xef`\xd5\x9c3,\xb8\x87"] = loadfxasset("j\x05p\xdf\xe6\"\xbf\x8d\xc3\xa2\xba|\x16\xe6x\xc3\x13\x82\x9a~HK\x90\x99*\xbd\v\x1b\xdcq@\xa2\xd4\xa8\x1c\x13\xa9h\xbb\xf0\xcb\xd1\aK\x90?\v:8\x1a\a\xdd\xef");
    level._effect["\xf0\xa8\x8a\x12\x1cL\xe4q\xe0g\xfe$\xaa\xd8Qz\x04\x83\xbf\xed\xeb\xdb\xefk\xe4\xcc0\x1b\xa7\xd2\xac\x97cj\xb0\x1a\xc1\xe3\xc5\x80\xeb\xd5w\xa5u"] = loadfxasset("\x88\x18| \x1a\xb6\x94\xa4A2\xb8\xceG7\xfd\xf8\xfa\xe8mWc}tq\xe5\xb2\xa4\x19q\xa9\xeboO>h\xd4\xf1\x97\xe6\xf0\xf8\xa4\f\x9f\x95\x112\xc8D\x96Rw\xf7A");
    level._effect["\r\x86\xb3 \"\xe7\x9e\x9e\x910\x9c\\6\xd3\x13\x98k\xb94o\f\x9fV\xe0\xc4\xb5V\x98\xa1`\x9bfs\xd0`\xc2@\xae\x8aP\x15\x94Z\xed+"] = loadfxasset("\xc6%\x88\x9d\xc6C\x1f\xf3H\xfaw\xd1\xddU\xc0\xf6\x97\xb44/E\x96\x8a\xfb\xb0\xdaG\xe7~\xf2'\x87V\xa7@\xdd\x97%Z\xc0\xf8\xfa\x96v\x0eUw\x15U\x04$>\x19\x96");
    level._effect["f\xe905c6\xbe/\x89go lqo\xb1\x9akA:\xe4,\xa0\xff(\x93+\x16\xf3^\xe5\xd0\xb0\xf7\x80F\xa3,\a\x0e\x06\xeer\xa5r\xfa"] = loadfxasset("\xe7\xec\x87T7\xf4\x83\x1a\xe5\xab\xca\x9b\xd5\xc8\x87Jy\x06)\xa9u\x05\xa9\x9c\xbf\x8b\xd4\xaagN\xc3l\xa8#M\x03\x84\x81\fS\xb1\xbcR\x12\x81&\x80\xba\x12\xb2\xebd\xcb\xc1\xf4");
    level._effect[";\xcc\xf0\xbe+\x0f\xb2c\xd7\xe6:l\xd1\r\xfa\xb5\xb9-\xcce\xaf39\xdbn:\xf5\x85\xafL\x1boo2\xbe\xe6\x8dXs4\xd7\xc0\x13"] = loadfxasset("\x9d\x99x\xbe:L\x81}6\xb7re\xd7\xac\xe1V\xb1\xf5\x9b\x1d\x8dth\xbe[sZ3Y\xeb\x999\xdbn\x8e},\xfa&\xc6\xdb\xf6\x91\xeb\xb9ca\xdc\xd0\xbe\xc01");
    level._effect["\xbd\xa37\x9bS\x96\xc1\xfd\\\xa3\xcf\xc9\x9e\xb8\xbe#\xaa\xda\xf4%\xd1<4\xcf^\xa0rh%z\x90\xf6l\x8arqdJ\v\x9f\xc1\"q"] = loadfxasset("v3x\xaf:1`\xaf\x1b{r\xac_Y\x1e\xb2\xb1}\x9b\xe86G\x1a\xaf\xdas-\xcc\xb2}fN\xed7\x8e\xd7,\xaf\x896\xed\xb72\xebs\x1ba\xb9\x86\xeb`d");
    level._effect["\xec3x\xbe\xcaxYl_\x9bG\xc6\xe8\r_\xb6\xdc\x96\x99+\xbe\x93+aN}\x16\xaf&c\xbd\xde\x19\xfa7:\x16b"] = loadfxasset("\xa3\x06q\x1b\xf2J\xea-K\xf0\xe3P\x1b?\xf3\xc1\x05\xcc\xb7]B\xf8(Mj8n\xd7\x7f\xe1\xa6\xcdE\xaa\xe2w\xa5\xebhk\xcaH}z]\xbd%");
    level._effect["\xe8\xf9\xc2-8O\x99\x94eC6\x03\xe1p\x96\xb2\b\xe1?\xd1D\xea=S\x96\x1b\xe3\x97\xc2\x15p\x851&'AK\xbce\xb7\xfc\xfd\x8fr"] = loadfxasset("0,\x03\x98\xb6\x92\xc1<\x1e\xe1\x9e\xf6\x8e\xfdNR \xb8\x1a\x9dsq>&.\n8\x87;\xfeh\xfe;]\x87\xd3\xdd\xe0\xe2\xdb\x82\x10\x12\x99\xd40k\x88\x86\x86v\xab%");
    level._effect["\x9e\xc3,g\xacuO\xff\xffx1\xd2d\x02\x15\xe3\r\xce\xba\x1e\b\x8c\xe3\xe7\xda|M\xc1A\x97\x9a\x0e\x1a\x99\x10\n\x06\xd7\xf4"] = loadfxasset("C\xf3g\xe6tQ\xf8\xb6#\x90*\xc1'\x88\xc8\x01Z#\xaf\x16\xa6-5\xd9\xfc\xeb\xad\xf8\x05\x9a\xcb\xd7\xb8\to%[\xa3s\xcb5\xa4a\xc3+\x065\x9b");
    level._effect["\xd8\xd0\xc9#\xd5j\x8bm7\xb3\xd8B\x90A\xca\xacI\xec\xf2\xdf0\x01\xe0\xdb\x06\x948oh\xfc\x05D\xbfRm\xfaC\xea\x1b3d\x19"] = loadfxasset("n\x9c\xe2\x9c\xfe\xfbH\xcer]OM|\xfa\xc1f\x92`c\xb1n\xf1\x8d\xed\xcf\xddE \xe1\xbc$\x01\xe19=\xc1\x1f\xa5L.^q\xc6]\f\x94\xde;\x17\xdb3");
    level._effect["\x14\x03\xc1\x9f\xda\x16\xdfg6\xca\x19\x18\xc3(\xf4<\x81\xd3i\x8bwN|nY\x81\xa2?)\x84\xdd\xa1\x8a\x8b~\xc4<{\xd6\xc5FF\xcc\x95\x84\xf9"] = loadfxasset("\x87\x96\xdcf28'y7\vQ\"\xf7\xcb\x88\af9\xf0X1\x89\xd9\x1fDi\b\x05_0\x9a\xdf\xae\xbc:\xa7\x03\xfb\x010\xc2\xb2\x98\xf9B\xf7\xeb|\x06z\xdd\x1c3\xb7\x89");
    level._effect["%\xd1\x05}Bm\x01;9\x90\xcd\xb9\xf7-\xa2\xc9D\x7f\x9e\xee\xfe\x85q\v\x93\x8f#\xcc\x99\xf4f\xcf\x8dW\xf9g]\xba\x8e"] = loadfxasset("Nz\x96\xadhoi\xee\xb0\xee\xbf1>\x7fT&F\x91\xc56\xb5\xd0\xe0B\nHAx=\xd0\xd6\xf7[\x93@\x13G\x068\x9b;\xe6i#\x16@\x13\v");
    level notify("\xcc\x8d\x9f\xdbS-9\xec\x8e\xaa\x1c\\\n{\x15\x86\xbc)");
    level notify("n\x8d'\x96p\x1d\xcaF_mV\x8de\xac\xbes\xa3\xbd\x83");
    level.player notifyonplayercommandremove("\xc1\xd8XyYN\xaf\xe6cr\xd2\x83t+2}k\xca\xc6\xca+", "\x18\xf77d\x8e\\\x1fjq\xbd(");

    level thread debug_thread();

    val::register("y\x9e\xfa\xb1\x95.\x839", 1, 0, "\x127\xca\x8d3", &function_ec92b827f318869f, "~\xa9\xccdcE");
    val::register("\xeew:\x84\xb8a@9\xb5\xb1\x87H\x19.", 0, 1, "\x127\xca\x8d3", &function_bed5b632c1a64b0, "~\xa9\xccdcE");
    val::register("\xa2@4\xbae\xd4\x81p\x9fD\xb1Hh\xad\xe9\xe4pP", 0, 1, "\x127\xca\x8d3", &function_ba6947b911a9fa42, "~\xa9\xccdcE");
    level.enableexecutionvictimfunc = &function_73a0d084c91e2198;
    level.disableexecutionvictimfunc = &function_11486106428ea761;
    level.scenetagtests["\x13\\\x8f\xf4"] = &function_4c793df85c7198e5;
  }
}

function private function_73a0d084c91e2198() {
  val::reset("\xbe\xe6h\x06\x89", "y\x9e\xfa\xb1\x95.\x839");
}

function private function_11486106428ea761() {
  val::set("\xbe\xe6h\x06\x89", "y\x9e\xfa\xb1\x95.\x839", 0);
}

function private function_ec92b827f318869f(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(isDefined(self.takedown)) {
    self.takedown.disabled = b_value ? undefined : 1;
  }

  if(!isPlayer(self)) {
    self.var_3aa831911040255c = b_value ? undefined : 1;
  }
}

function private function_bed5b632c1a64b0(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(isDefined(self.takedown)) {
    self.takedown.forceallow = b_value ? 1 : undefined;
  }
}

function private function_ba6947b911a9fa42(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(isDefined(self.takedown)) {
    self.takedown.nonlethal = b_value ? 1 : undefined;
  }
}

function private debug_thread() {
  self notify("<dev string:x28>");
  self endon("<dev string:x28>");

  while(true) {
    player = level.player;

    if(!isDefined(player.takedown.debug)) {
      player.takedown.debug = spawnStruct();
    }

    player.takedown.debug.takedown_disable = getdvarint(@ "hash_391d954ec12a55c3", 0) ? 1 : undefined;
    player.takedown.debug.enabled = getdvarint(@ "hash_3ee9189d52e605f8", 0) ? 1 : undefined;
    player.takedown.debug.nonlethal = getdvarint(@ "hash_be88768943ca7f16", 0) ? 1 : undefined;
    player.takedown.var_d026b5e6138815b4 = getDvar(@ "hash_c5a1703db7b78b53", "<dev string:x24>");
    wait 1;
  }
}

function private function_9ef9b4fe696f3de6() {
  var_d1084d01cf1ecbbe = getscriptbundlenames("y\x9e\xfa\xb1\x95.\x839");

  foreach(bundle_name in var_d1084d01cf1ecbbe) {
    level function_6cb4cd78729f7929(bundle_name);
  }
}

function private function_6cb4cd78729f7929(bundle_name) {
  takedown = getscriptbundle(bundle_name);

  if(!isDefined(takedown)) {
    return;
  }

  assert(isDefined(level.takedowns));
  takedownstored = spawnStruct();
  takedownstored.scenes = [];
  takedownstored.scene_tags = [];

  if(isDefined(takedown.scenes)) {
    foreach(scene in takedown.scenes) {
      if(isDefined(scene.scene) && scene.scene != "") {
        takedownstored.scenes[takedownstored.scenes.size] = scene.scene;

        if(isDefined(scene.tags) && scene.tags != "") {
          takedownstored.scene_tags[scene.scene] = strtok(scene.tags, "\b\x95g");
        }
      }
    }
  }

  if(takedownstored.scenes.size > 0) {
    takedownstored.name = bundle_name;

    takedownstored.display_name = getxhashsourcename(bundle_name);

    takedownstored.prompt = takedown.prompt ?? undefined;
    takedownstored.nodeath = istrue(takedown.nodeath) ? 1 : undefined;
    takedownstored.combat = istrue(takedown.playercombat) ? 1 : undefined;
    takedownstored.noncombat = istrue(takedown.playernoncombat) ? 1 : undefined;
    takedownstored.sprint = istrue(takedown.playersprint) ? 1 : undefined;
    takedownstored.notsprint = istrue(takedown.playernotsprint) ? 1 : undefined;
    takedownstored.slide = istrue(takedown.playerslide) ? 1 : undefined;
    takedownstored.notslide = istrue(takedown.playernotslide) ? 1 : undefined;
    takedownstored.nonlethal = istrue(takedown.nonlethal) ? 1 : undefined;
    takedownstored.playerinwater = istrue(takedown.playerinwater) ? 1 : undefined;
    takedownstored.var_8145865bd32aa518 = istrue(takedown.var_8145865bd32aa518) ? 1 : undefined;
    takedownstored.playerpitchmax = takedown.playerpitchmax ?? 0;
    takedownstored.victimyaw = takedown.victimyaw ?? 0;
    takedownstored.var_e7700303e72295c7 = isDefined(takedown.victimyawrange) && takedown.victimyawrange < 180 ? anglesToForward((0, takedown.victimyaw ?? 0, 0)) : undefined;
    takedownstored.yawrangecos = isDefined(takedown.victimyawrange) && takedown.victimyawrange < 180 ? cos(takedown.victimyawrange ?? 0) : undefined;
    takedownstored.minrange = isDefined(takedown.victimminrange) && takedown.victimminrange > 0 ? takedown.victimminrange ?? 0 : undefined;
    takedownstored.maxrange = isDefined(takedown.victimmaxrange) ? takedown.victimmaxrange ?? 0 : undefined;
    takedownstored.minheight = takedown.victimminheight ?? undefined;
    takedownstored.maxheight = takedown.victimmaxheight ?? undefined;
    takedownstored.trace = istrue(takedown.victimtrace) ? 1 : undefined;
    takedownstored.traceheight = istrue(takedown.victimtrace) ? takedown.victimtraceheight : undefined;
    takedownstored.stancestand = istrue(takedown.victimstand) ? 1 : undefined;
    takedownstored.stancecrouch = istrue(takedown.victimcrouch) ? 1 : undefined;
    takedownstored.stanceprone = istrue(takedown.victimprone) ? 1 : undefined;
    takedownstored.orienttovictimyaw = istrue(takedown.orienttovictimyaw) ? 1 : undefined;
    takedownstored.victimteams = strtok(takedown.victimteams ?? "\x8e\x8e&\xe2C\x91\xccx\xc6\xef?", "\xf8\x01");
    takedownstored.victimanimnames = strtok(takedown.victimanimnames ?? "", "\xf8\x01");
    takedownstored.overridedamagesightrange = takedown.overridedamagesightrange ?? undefined;

    if(!isarray(takedownstored.victimanimnames)) {
      takedownstored.victimanimnames = [takedownstored.victimanimnames];
    }

    if(takedownstored.victimanimnames.size == 0) {
      takedownstored.victimanimnames = undefined;
    }

    if(!isarray(takedownstored.victimteams)) {
      takedownstored.victimteams = [takedownstored.victimteams];
    }

    level.takedowns.takedowns[bundle_name] = takedownstored;
    level.takedowns.maxrange = max(level.takedowns.maxrange ?? 0, takedown.victimmaxrange ?? 0);
    return;
  }

  assertmsg("<dev string:x38>" + getxhashsourcename(bundle_name) + "<dev string:x47>");
}

function private function_c3e7f253ba50202c() {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(player.takedown)) {
    if(!isDefined(player.takedown)) {
      player.takedown = spawnStruct();
    }

    if(!isDefined(player.takedown.debug)) {
      player.takedown.debug = spawnStruct();
    }

    player.takedown.disabled = undefined;
    player.takedown.disable_drop = undefined;
    player.takedown.victim = undefined;
    player.takedown.rangeextend = undefined;

    level thread debug_thread();
  }
}

function private function_4f919f20abb98492(enabled) {
  assert(isPlayer(self));
  player = self;
  player function_c3e7f253ba50202c();

  if(istrue(enabled)) {
    player thread takedown_input_monitor();
    return;
  }

  player notify("\x15\xecc\x89v\xe2=\x14\xf3\xb8-\x81m\x12B\xff\xbe\x9e\xb2a\xee\xdes");
  player notify("\xcd\x04\xc0\x87q7\x8c\xb5,\xb8\x11Z\x9f\x83:\x05\x16\xda\x80\x03\xd5\x9c");
  player val::reset_all("\xae\xa2\xe5E\xaeN\xf5]\xd3\x06{\xa7bV\xb7\x98\xc8\xc7\x8f\xa8");
}

function private takedown_input_monitor() {
  assert(isPlayer(self));
  player = self;
  player notify("\xcd\x04\xc0\x87q7\x8c\xb5,\xb8\x11Z\x9f\x83:\x05\x16\xda\x80\x03\xd5\x9c");
  player endon("\xcd\x04\xc0\x87q7\x8c\xb5,\xb8\x11Z\x9f\x83:\x05\x16\xda\x80\x03\xd5\x9c");
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player childthread function_6f0d9a723e0aece9();
  player thread function_84e51536270dcbfd();

  while(true) {
    waitframe();
    player thread takedown_prompt_monitor();
    player waittill("\xdc(\xb1\x05\xa2o\xff\xde\xcd\xb7\x13\xb6\x1dw\xd4\x9c\xbc\x1c3\x18\xb2w\x1f\xee\x0eO\xfd\xb5c");
    player notify("\x15\xecc\x89v\xe2=\x14\xf3\xb8-\x81m\x12B\xff\xbe\x9e\xb2a\xee\xdes");

    if(istrue(player.in_melee_death)) {
      player function_78daa2c7f7c985b7("<dev string:x60>", 1);

      continue;
    }

    if(!player val::get("\x86X7\x8c\xdc")) {
      player function_78daa2c7f7c985b7("<dev string:x79>", 1);

      continue;
    }

    if(istrue(player.takedown.disabled)) {
      player function_78daa2c7f7c985b7("<dev string:x92>", 1);

      continue;
    }

    if(!isalive(player.takedown.victim)) {
      player function_78daa2c7f7c985b7("<dev string:xae>", 1);

      continue;
    }

    if(!player.takedown.victim val::get("y\x9e\xfa\xb1\x95.\x839")) {
      player function_78daa2c7f7c985b7("<dev string:xd4>", 1);

      continue;
    }

    if(!isDefined(player.takedown.scene)) {
      player function_78daa2c7f7c985b7("<dev string:x107>", 1);

      continue;
    }

    if(!player function_9b96d9e774c75c92()) {
      player function_78daa2c7f7c985b7("<dev string:x12e>", 1);

      continue;
    }

    if(isDefined(level.takedowns.callbackoverride)) {
      player[[level.takedowns.callbackoverride]]();
      continue;
    }

    player takedown_begin(player.takedown.victim, player.takedown.scene);
  }
}

function private function_84e51536270dcbfd() {
  assert(isPlayer(self));
  player = self;
  player waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player input_prompts::close_group("\x91\xca\xcc\v\xab\xd8:");
}

function function_6f0d9a723e0aece9() {
  assert(isPlayer(self));
  player = self;

  while(true) {
    player waittill("\a\x10P\xde\x8cq\xf8\xffTD\x15\xebC\xd7\x88\x1a\t\\p\xc6^");
    victim = player.takedown.var_a9954958f4d0ca0b;

    if(isDefined(victim.sidearm)) {
      victim shared::detachweapon(victim.sidearm);
      victim.sidearm = nullweapon();
      victim shared::updateattachedweaponmodels();
    }
  }
}

function takedown_begin(victim, scene) {
  assert(isPlayer(self));
  player = self;
  player.takedown.weapon = player getcurrentweapon();
  player.takedown.start_origin = player.origin;
  player.takedown.start_demeanor = player getdemeanorviewmodel();
  player.in_melee_death = 1;
  player val::set("y\x9e\xfa\xb1\x95.\x839", "\x86X7\x8c\xdc", 0);
  player val::set("y\x9e\xfa\xb1\x95.\x839", "\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9", 2);
  player val::set("y\x9e\xfa\xb1\x95.\x839", "\xcb\xd8\x17e\xf60Q\x02\x1f\xbd\xfd\x1e\xcb\xe5", 0);
  player val::set("y\x9e\xfa\xb1\x95.\x839", "(\x15\xda\x106\xed_\x1a", "+0a<s,");
  player.takedown.attempt_victim = victim;
  stealth_kill = !player stealth_manager::anyone_in_combat() && istrue(player.takedown.takedown.noncombat);

  if(!stealth_kill && !player utility::ent_flag("\xf6\xf5\x163\x9b\xf2(\xfdY\xd8E\x95\x01\x99\x05\xb5\x97\xc3\x1f\x05\xe2\xc1\xf8\x18y\x80]\x80e")) {
    createnavrepulsor("y\x9e\xfa\xb1\x95.\x839", 0, victim, 215, 1, "\x9a\x1f\x83\x1bs=\x13\xf8");
    player.takedown.var_465d9063611f1221 = 1;
  }

  if(isDefined(victim.stealth) && stealth_kill) {
    victim.stealth.override_damage_auto_range = 60;
  }

  player setsoundsubmix("s\xe0\xfa\x8e\x89\xc0_\x8e,\xd6+\x91\xedw\xb9", 0.1);
  victim notify("3\xdcu\xe6|\xecw\xf3 \x88m\x81\x95\xeb");
  victim.ignoreall = 1;
  victim.ignoreme = 1;
  victim.syncedmeleetarget = undefined;
  victim.dontattackme = 1;
  victim.diequietly = 1;
  victim.in_melee_death = 1;
  victim.lastattacker = player;
  victim.forceweapondrop = 1;
  victim notify("\xf98\xa0\x95\xf6\xdey\xa4\xe3?\xd9\xb70\xf8\xda");
  victim val::set("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca", 1);
  victim function_b567b456f8b58cfa(scene, player);
}

function function_9b96d9e774c75c92() {
  assert(isPlayer(self));
  player = self;
  now = gettime();

  if((player.takedown.var_8135a321bcd5ed58 ?? -1) == now) {
    return player.takedown.var_9b96d9e774c75c92;
  }

  player.takedown.var_9b96d9e774c75c92 = 1;
  stance = player getstance();

  if(istrue(player.takedown.forceallow) && isalive(player)) {
    player function_78daa2c7f7c985b7("<dev string:x147>");

    player.takedown.var_8135a321bcd5ed58 = now;
    return player.takedown.var_9b96d9e774c75c92;
  }

  if(!player val::get("y\x9e\xfa\xb1\x95.\x839")) {
    player function_78daa2c7f7c985b7("<dev string:x159>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(!isalive(player)) {
    player function_78daa2c7f7c985b7("<dev string:x175>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(isDefined(player getlinkedparent())) {
    player function_78daa2c7f7c985b7("<dev string:x182>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(istrue(player.takedown.disabled)) {
    player function_78daa2c7f7c985b7("<dev string:x196>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(stance == "GX\xa9]\x82") {
    player function_78daa2c7f7c985b7("<dev string:x1a2>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player isthrowinggrenade()) {
    player function_78daa2c7f7c985b7("<dev string:x1ab>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player getcurrentweapon().basename == "\r+x5") {
    player function_78daa2c7f7c985b7("<dev string:x1b7>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(!player val::get("\x86X7\x8c\xdc")) {
    player function_78daa2c7f7c985b7("<dev string:x79>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(istrue(player.var_20f6e2ea824baab9)) {
    player function_78daa2c7f7c985b7("<dev string:x1c4>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player killstreaks::getkillstreakinuse()) {
    player function_78daa2c7f7c985b7("<dev string:x1db>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player utility::ent_flag("#\xb1\xbb\x16\xb8\xbd\xbe\xcd\xder\x1d\x12\x16\xd6\x99-\x93x")) {
    player function_78daa2c7f7c985b7("<dev string:x1ec>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player isoffhandweaponreadytothrow()) {
    player function_78daa2c7f7c985b7("<dev string:x202>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player isonladder() || player jumpbuttonPressed() || player isjumping() || player isparachuting() || player isskydiving() || player isonascender()) {
    player function_78daa2c7f7c985b7("<dev string:x21f>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(player isgestureplaying("\xafAr\xfbh^)e'\xce\xdbP\xcf\xec\xc3\xfe\x05e\xc7\xc6z")) {
    player function_78daa2c7f7c985b7("<dev string:x239>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  } else if(!player player_sp::canstand(level.takedowns.collisioncontentsstand)) {
    player function_78daa2c7f7c985b7("<dev string:x285>", 1);

    player.takedown.var_9b96d9e774c75c92 = 0;
  }

  player.takedown.var_8135a321bcd5ed58 = now;
  return player.takedown.var_9b96d9e774c75c92;
}

function private takedown_playerpresscomplete(group, prompt) {
  self notify("\xdc(\xb1\x05\xa2o\xff\xde\xcd\xb7\x13\xb6\x1dw\xd4\x9c\xbc\x1c3\x18\xb2w\x1f\xee\x0eO\xfd\xb5c");
}

function private takedown_playerpresscompletelonghold(group, prompt) {
  self notify("\xdc(\xb1\x05\xa2o\xff\xde\xcd\xb7\x13\xb6\x1dw\xd4\x9c\xbc\x1c3\x18\xb2w\x1f\xee\x0eO\xfd\xb5c");
  self.takedown.long_hold = 1;
  self notify("\x06P\xd0\xcf\xe4Q\xec\xbe\x85d\x93\xe3\a?\b=\x8c\\\xe0\x86\xbc>(3\x89E\x11\xbf\xa7\a\xe0\xd2\xc3\xcf\x15\xbc");
}

function private function_4e6911887421e92e(takedownprompt) {
  player = self;
  set_val = 0;

  if(isDefined(takedownprompt)) {
    if(!istrue(player.takedown.var_d06efff6642cc72a)) {
      player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "y\x9e\xfa\xb1\x95.\x839", takedownprompt, 0, 1, 1, 1, &takedown_playerpresscomplete);
    }

    set_val = 1;
  } else if(istrue(player.takedown.var_d06efff6642cc72a)) {
    player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "y\x9e\xfa\xb1\x95.\x839", 0);
  }

  player.takedown.var_d06efff6642cc72a = set_val;
}

function private function_f59fbbad2226f9b6(var_eaba7ebe5ba314ca) {
  player = self;
  set_val = 0;

  if(isDefined(var_eaba7ebe5ba314ca)) {
    if(!istrue(player.takedown.var_2a3c4f75c1b8bf27)) {
      player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "\xed\xb1\xdeO`\x0f\x9a\xa4\xfc\xfb", var_eaba7ebe5ba314ca, 0.25, 1, 1, 1, &takedown_playerpresscompletelonghold);
    }

    set_val = 1;
  } else if(istrue(player.takedown.var_2a3c4f75c1b8bf27)) {
    player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "\xed\xb1\xdeO`\x0f\x9a\xa4\xfc\xfb", 0);
  }

  player.takedown.var_2a3c4f75c1b8bf27 = set_val;
}

function private function_fa0ae9e347b5d1ee(var_be860da479913521) {
  player = self;

  if(isDefined(player.takedown.var_be860da479913521) && (!isDefined(var_be860da479913521) || var_be860da479913521["|\xf1Y0"] != player.takedown.var_be860da479913521["|\xf1Y0"])) {
    player hud_management::scripted_widget_destroy("R|\xaf\x83\x81\xc94\xf6v\x10\x8c2\x89L\xcc\xc3\v\\/");
    player.takedown.var_be860da479913521 = undefined;
  }

  if(isDefined(var_be860da479913521) && !isDefined(player.takedown.var_be860da479913521)) {
    if(isDefined(var_be860da479913521["Zm\x16;\xac"])) {
      player.takedown.var_be860da479913521 = var_be860da479913521;
      player hud_management::function_35924dfcb78711f4("R|\xaf\x83\x81\xc94\xf6v\x10\x8c2\x89L\xcc\xc3\v\\/", "\xab\x95\xe3eR\xf6\xab\xd8\x8d\tg\xe2\x9c\x98\x06\x0f\t/\r\\\xd5\xea0Zu$C|.W#\xcfoQ'\xd9@\x17");
      player hud_management::function_41ff479ac45608d6("R|\xaf\x83\x81\xc94\xf6v\x10\x8c2\x89L\xcc\xc3\v\\/", var_be860da479913521);
      player hud_management::function_85d8a0ba2e35b6f2("R|\xaf\x83\x81\xc94\xf6v\x10\x8c2\x89L\xcc\xc3\v\\/", 0, 200, 1, 1);
    }
  }
}

function takedown_prompt_monitor() {
  player = self;
  player notify("\x15\xecc\x89v\xe2=\x14\xf3\xb8-\x81m\x12B\xff\xbe\x9e\xb2a\xee\xdes");
  player endon("\x15\xecc\x89v\xe2=\x14\xf3\xb8-\x81m\x12B\xff\xbe\x9e\xb2a\xee\xdes");
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player function_4e6911887421e92e();
  player function_f59fbbad2226f9b6();

  while(true) {
    waitframe();

    player function_78daa2c7f7c985b7("<dev string:x294>");

    if(isDefined(player.takedown.victim) && istrue(player.takedown.allow_melee)) {
      player function_a6205a5dd6ff9a6d(undefined);
    }

    if(level utility::flag("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b")) {
      player function_78daa2c7f7c985b7("<dev string:x2a2>", 1);

      player takedown_allow_melee(1);
      level utility::flag_waitopen("R\x1fB.\xc9\a\xdf\xe51q\x11K\xf1\xec\xa3)e\b");
    }

    var_857acd8d306737a9 = undefined;

    if(player function_9b96d9e774c75c92()) {
      var_857acd8d306737a9 = player function_edb123e4eb1583f0();

      if(isDefined(var_857acd8d306737a9)) {
        function_fa0ae9e347b5d1ee();
        player.takedown.scene = var_857acd8d306737a9[0];
        player.takedown.takedown = var_857acd8d306737a9[1];
        player function_a6205a5dd6ff9a6d(var_857acd8d306737a9[2]);

        var_857acd8d306737a9[2] function_78daa2c7f7c985b7(player.takedown.scene);

        player function_78daa2c7f7c985b7("<dev string:x2b8>" + var_857acd8d306737a9[2] getentitynumber());

        var_73e4569685a3adbf = player.takedown.takedown.prompt ?? &"hash_1efbdfd2867a6c38";
        player function_4e6911887421e92e(var_73e4569685a3adbf);
        player.takedown.var_ecfd49546c4f9e70 = function_36fc1bafdbe3974(level.takedown_grabs, player.takedown.victim, player);

        var_857acd8d306737a9[2] function_78daa2c7f7c985b7(player.takedown.var_ecfd49546c4f9e70[0]);

        var_e188de919b400af8 = player function_ca527233758eb9a8();

        if(var_e188de919b400af8) {
          var_725ab238f70597d1 = player.takedown.var_ecfd49546c4f9e70[1].prompt ?? &"hash_7509bd77f815f105";
          player function_f59fbbad2226f9b6(var_725ab238f70597d1);
        } else {
          player function_f59fbbad2226f9b6();
        }

        player takedown_allow_melee(0);

        if(getdvarint(@ "hash_3ee9189d52e605f8", 0) && isent(var_857acd8d306737a9[0]) && isDefined(var_857acd8d306737a9[1])) {
          debugstar(var_857acd8d306737a9[0].origin + (0, 0, 30), 1, (1, 0, 0), var_857acd8d306737a9[1], 0.1);
        }
      }
    }

    if(!isDefined(var_857acd8d306737a9)) {
      player function_4e6911887421e92e();
      player function_f59fbbad2226f9b6();
      player function_fa0ae9e347b5d1ee(player function_247d54aea8252c8e());

      player function_78daa2c7f7c985b7("<dev string:x2c4>");

      player function_a6205a5dd6ff9a6d(undefined);

      if(!istrue(player.in_melee_death)) {
        player takedown_allow_melee(1);
      }
    }
  }
}

function private function_ca527233758eb9a8() {
  return !utility::ent_flag("\xc7?\x16|\x01\x84\xca\xbb\xb5\xdf\xc7\xb0\xec\xb0\xb7\xb0\x89:D\x17") && !istrue(self.takedown.victim.disallowbodyshield) && isDefined(self.takedown.var_ecfd49546c4f9e70[0]) && isDefined(carrylinked::function_d6e3fcacd7c95239()) && !self isswimming();
}

function private function_247d54aea8252c8e() {
  player = self;

  if(!isDefined(player.takedown.potential_victims)) {
    return;
  }

  if(player.takedown.potential_victims.size > 0) {
    foreach(victim in player.takedown.potential_victims) {
      if(isent(victim)) {
        victim function_f20b54d9e71264d0(player);

        if(victim.var_39e5fb13996ec578.facing_yaw && victim.var_39e5fb13996ec578.var_68c4d15c091b1d66 <= 35) {
          prompt = victim function_476f590ea68defd();

          if(isDefined(prompt)) {
            return prompt;
          }
        }
      }
    }
  }
}

function private function_476f590ea68defd() {
  if(isDefined(self.var_476f590ea68defd)) {
    foreach(func in self.var_476f590ea68defd) {
      prompt = self[[func]]();

      if(isDefined(prompt)) {
        return prompt;
      }
    }
  }
}

function function_2af7fe550c3c2202(victim) {
  assert(isPlayer(self));
  player = self;
  return vectorNormalize(victim.var_39e5fb13996ec578.check_origin - player getEye());
}

function takedown_scripted(victim) {
  assert(isPlayer(self));
  player = self;
  fwd = anglesToForward(player getplayerangles());
  evaldata = spawnStruct();
  success = player function_d8d05198afeaa5cb(victim, fwd, evaldata);

  if(success) {
    victim_scene = evaldata.result;
    player.takedown.scene = victim_scene[0];
    player.takedown.takedown = victim_scene[1];
    player function_a6205a5dd6ff9a6d(victim_scene[2]);

    if(isDefined(level.takedowns.callbackoverride)) {
      player[[level.takedowns.callbackoverride]]();
    } else {
      player takedown_begin(player.takedown.victim, player.takedown.scene);
    }
  }

  return success;
}

function function_edb123e4eb1583f0() {
  assert(isPlayer(self));
  player = self;
  now = gettime();

  if((player.takedown.var_79b46a43d277e8a0 ?? -1) != now) {
    maxrange = level.takedowns.maxrange + (player.takedown.rangeextend ?? 0);
    player.takedown.potential_victims = getaiarrayinradius(player.origin, maxrange, player.takedown.teamspossible);

    if(isDefined(player.takedown.specialvictims) && player.takedown.specialvictims.size > 0) {
      player.takedown.specialvictims = utility::array_removedead_or_dying(player.takedown.specialvictims, 1);
      player.takedown.potential_victims = utility::array_combine(player.takedown.potential_victims, player.takedown.specialvictims);
    }

    player.takedown.var_79b46a43d277e8a0 = now;
  }

  if(player.takedown.potential_victims.size > 0) {
    fwd = anglesToForward(player getplayerangles());
    evaldata = spawnStruct();

    foreach(victim in player.takedown.potential_victims) {
      player function_d8d05198afeaa5cb(victim, fwd, evaldata);
    }

    return evaldata.result;
  }

  return undefined;
}

function private function_d8d05198afeaa5cb(victim, playerforward, outdata) {
  player = self;

  if(utility::is_dead_or_dying(victim)) {
    victim function_78daa2c7f7c985b7("<dev string:x2d1>", 1);

    return false;
  }

  if(istrue(victim.var_3aa831911040255c)) {
    victim function_78daa2c7f7c985b7("<dev string:x2e5>", 1);

    return false;
  }

  if(victim utility::ent_flag("K'\x94\x99}\x99\a_\x9e\x80c\xa7\f")) {
    useent = player getplayeruseentity();

    if(isDefined(useent) && isDefined(victim.cursor_hint_ent) && victim.cursor_hint_ent == useent) {
      victim function_78daa2c7f7c985b7("<dev string:x2f9>", 1);

      return false;
    }
  }

  if(victim.takedamage == 0) {
    victim function_78daa2c7f7c985b7("<dev string:x316>", 1);

    return false;
  }

  if(istrue(victim.magic_bullet_shield) || istrue(victim.damageshield)) {
    victim function_78daa2c7f7c985b7("<dev string:x32d>", 1);

    return false;
  }

  if(victim.type != "\x1aW\xb6\xc2\xe6" && victim.type != "\x9b\x11\"\xd6\xfb;") {
    victim function_78daa2c7f7c985b7("<dev string:x344>", 1);

    return false;
  }

  if(isDefined(player.carrylinked)) {
    victim function_78daa2c7f7c985b7("<dev string:x35b>", 1);

    return false;
  }

  if(utility_sp::isriotshield(player getcurrentweapon())) {
    victim function_78daa2c7f7c985b7("<dev string:x38d>", 1);

    return false;
  }

  if(isDefined(victim.takedown_range)) {
    if(distance2dsquared(victim.origin, player.origin) > squared(victim.takedown_range)) {
      victim function_78daa2c7f7c985b7("<dev string:x3a6>" + distance2d(victim.origin, player.origin), 1);

      return false;
    }
  }

  if(!victim function_2aebc9f488968b02(player)) {
    return false;
  }

  victim_scene = function_6b50a73757f8446b(victim, player);

  if(isDefined(victim_scene[0])) {
    dir = player function_2af7fe550c3c2202(victim);
    dot = vectordot(playerforward, dir);

    if(!isDefined(outdata.best_dot)) {
      outdata.best_dot = -1;
    }

    if(dot > outdata.best_dot) {
      outdata.best_dot = dot;

      if(isstring(victim.takedown_scene)) {
        victim_scene[0] = victim.takedown_scene;
      } else if(isstring(victim.var_173da44c98645c7b) || isstring(victim.var_501f8acd63c98364)) {
        cosbehind = -0.7;
        victimfwd = anglesToForward(victim.angles);
        playerdelta = vectorNormalize(player.origin - victim.origin);
        dot = vectordot(playerdelta, victimfwd);

        if(isstring(victim.var_173da44c98645c7b) && dot <= cosbehind) {
          victim_scene[0] = victim.var_173da44c98645c7b;
        } else if(isstring(victim.var_501f8acd63c98364) && dot >= cosbehind) {
          victim_scene[0] = victim.var_501f8acd63c98364;
        }
      }

      if(isDefined(player.takedown.var_d026b5e6138815b4) && player.takedown.var_d026b5e6138815b4 != "<dev string:x24>" && isDefined(getscriptbundle("<dev string:x3b2>" + player.takedown.var_d026b5e6138815b4))) {
        victim_scene[0] = player.takedown.var_d026b5e6138815b4;
      }

      victim_scene[2] = victim;
      outdata.result = victim_scene;
      return true;
    }
  }

  return false;
}

function function_36fc1bafdbe3974(takedownspossible, victim, player) {
  var_800969332d2af93c = [];

  foreach(takedown in takedownspossible) {
    validplayer = player function_5ca800975208250e(takedown, victim);

    if(validplayer) {
      validvictim = victim function_5137849d975570a7(takedown, player);

      if(validvictim) {
        var_800969332d2af93c[var_800969332d2af93c.size] = takedown;
      }
    }
  }

  resulttakedown = undefined;
  resultscene = undefined;

  if(var_800969332d2af93c.size > 0) {
    resulttakedown = var_800969332d2af93c[randomintrange(0, var_800969332d2af93c.size)];
    deck = player function_32c76f8ed79daada(resulttakedown);
    startcycle = deck.cycle;
    resultscene = deck utility::deck_top();
    var_8df0ee3f919408c3 = player function_a71d07c6de33b796();

    while(!player function_637fb15965573e95(resulttakedown, resultscene, var_8df0ee3f919408c3) && deck.cycle - startcycle < 2) {
      deck utility::deck_draw();
      resultscene = deck utility::deck_top();
    }
  }

  return [resultscene, resulttakedown];
}

function function_6b50a73757f8446b(victim, player) {
  assert(isPlayer(player));
  assert(isai(victim));
  resultscene = undefined;
  resulttakedown = undefined;
  victim function_f20b54d9e71264d0(player);
  takedownspossible = level.takedowns.takedowns;

  if(isDefined(player.takedown.takedownspossible)) {
    takedownspossible = player.takedown.takedownspossible;
  }

  if(isDefined(victim.takedown_override)) {
    takedownspossible = [];
    takedown_override = victim.takedown_override;

    if(!isarray(takedown_override)) {
      takedown_override = [takedown_override];
    }

    foreach(takedownname in takedown_override) {
      assetname = getxhashasset("s'\xf9\xd0J\x1e\x14u\xe3" + takedownname);
      takedownspossible[takedownspossible.size] = level.takedowns.takedowns[assetname];
    }
  }

  return function_36fc1bafdbe3974(takedownspossible, victim, player);
}

function function_5ca800975208250e(takedown, victim) {
  assert(isPlayer(self));
  assert(isDefined(takedown));
  player = self;

  if(istrue(player.takedown.debug.takedown_disable)) {
    player function_78daa2c7f7c985b7("<dev string:x3c8>", 1);
    return false;
  }

  if(weapon::isakimbo(player getcurrentprimaryweapon())) {
    player function_78daa2c7f7c985b7("<dev string:x3e2>", 1);

    return false;
  }

  nonlethalmode = istrue(player.takedown.nonlethal);

  nonlethalmode |= istrue(player.takedown.debug.nonlethal);

  if(nonlethalmode != istrue(takedown.nonlethal)) {
    player function_78daa2c7f7c985b7("<dev string:x3f3>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!victim.var_39e5fb13996ec578.facing_yaw) {
    victim function_78daa2c7f7c985b7("<dev string:x40d>", 1);

    return false;
  }

  if(takedown.playerpitchmax > 0 && victim.var_39e5fb13996ec578.var_68c4d15c091b1d66 > takedown.playerpitchmax) {
    victim function_78daa2c7f7c985b7("<dev string:x41f>" + victim.var_39e5fb13996ec578.var_68c4d15c091b1d66, 1);

    return false;
  }

  if(!istrue(takedown.sprint) && player issprinting()) {
    player function_78daa2c7f7c985b7("<dev string:x434>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!istrue(takedown.notsprint) && !player issprinting()) {
    player function_78daa2c7f7c985b7("<dev string:x443>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!istrue(takedown.slide) && player issprintsliding()) {
    player function_78daa2c7f7c985b7("<dev string:x456>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!istrue(takedown.notslide) && !player issprintsliding()) {
    player function_78daa2c7f7c985b7("<dev string:x463>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  swimming = player isswimming();

  if(!istrue(takedown.playerinwater) && swimming) {
    player function_78daa2c7f7c985b7("<dev string:x474>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!istrue(takedown.var_8145865bd32aa518) && !swimming) {
    player function_78daa2c7f7c985b7("<dev string:x482>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!player function_2aebc9f488968b02(victim)) {
    return false;
  }

  return true;
}

function function_5137849d975570a7(takedown, player) {
  assert(isactor(self));
  victim = self;

  if(!(isDefined(takedown) && isDefined(player))) {
    return false;
  }

  if(isent(victim.vehicle)) {
    return false;
  }

  distsqr = distancesquared(player.origin, victim.origin);
  combat = victim function_7d5fb6e446365c88(player);

  if(!istrue(victim.var_af7fea4e8725c3cd)) {
    if(!istrue(takedown.combat) && combat) {
      player function_78daa2c7f7c985b7("<dev string:x494>" + takedown.display_name + "<dev string:x408>", 1);

      return false;
    }

    if(!istrue(takedown.noncombat) && !combat) {
      player function_78daa2c7f7c985b7("<dev string:x4a0>" + takedown.display_name + "<dev string:x408>", 1);

      return false;
    }
  }

  minrange = takedown.minrange;

  if(isDefined(player.takedown.overrideminrange)) {
    minrange = player.takedown.overrideminrange;
  }

  if(isDefined(minrange) && distsqr < squared(minrange)) {
    victim function_78daa2c7f7c985b7("<dev string:x4b0>" + minrange + "<dev string:x4be>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  maxrange = takedown.maxrange;

  if(isDefined(player.takedown.overridemaxrange)) {
    maxrange = player.takedown.overridemaxrange;
  }

  if(isDefined(maxrange) && distsqr > squared(maxrange + (player.takedown.rangeextend ?? 0))) {
    victim function_78daa2c7f7c985b7("<dev string:x3a6>" + maxrange + (player.takedown.rangeextend ?? 0) + "<dev string:x4be>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  victimpose = victim.currentpose;

  if(!isDefined(victimpose)) {
    victimpose = victim asm_bb::bb_getrequestedstance();

    if(!isDefined(victimpose)) {
      victimpose = "\x8b\x90\xb5\xc4W";
    }
  }

  switch (victimpose) {
    case #"hash_c6775c88e38f7803":
      if(!istrue(takedown.stancestand)) {
        victim function_78daa2c7f7c985b7("<dev string:x4c4>" + takedown.display_name + "<dev string:x408>", 1);

        return false;
      }

      break;
    case #"hash_3fed0cbd303639eb":
      if(!istrue(takedown.stancecrouch)) {
        victim function_78daa2c7f7c985b7("<dev string:x4d2>" + takedown.display_name + "<dev string:x408>", 1);

        return false;
      }

      break;
    case #"hash_d91940431ed7c605":
      if(!istrue(takedown.stanceprone)) {
        victim function_78daa2c7f7c985b7("<dev string:x4e1>" + takedown.display_name + "<dev string:x408>", 1);

        return false;
      }

      break;
    default:
      return false;
  }

  if(isDefined(takedown.var_e7700303e72295c7) && isDefined(takedown.yawrangecos)) {
    headfwd = anglestoright(victim gettagangles("\xa6\xeb\x1ae\x85#")) * -1;
    feetfwd = anglesToForward(victim.angles);
    bodyfwd = vectorlerp(headfwd, feetfwd, 1);
    worlddir = rotatevector(takedown.var_e7700303e72295c7, (0, vectortoyaw(bodyfwd), 0));

    if(vectordot(worlddir, victim.var_39e5fb13996ec578.var_719e4f79192bc109) < takedown.yawrangecos) {
      victim function_78daa2c7f7c985b7("<dev string:x4ec>" + takedown.display_name + "<dev string:x408>", 1);

      return false;
    }
  }

  if(istrue(player.takedown.forceallow)) {
    victim function_78daa2c7f7c985b7("<dev string:x147>");

    return true;
  }

  deltaz = victim.origin[2] - player.origin[2];

  if(isDefined(takedown.minheight) && deltaz < takedown.minheight) {
    victim function_78daa2c7f7c985b7("<dev string:x4fc>" + abs(deltaz - takedown.minheight) + "<dev string:x4be>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(isDefined(takedown.maxheight) && deltaz > takedown.maxheight) {
    victim function_78daa2c7f7c985b7("<dev string:x508>" + abs(deltaz - takedown.minheight) + "<dev string:x4be>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(!arraycontains(takedown.victimteams, victim.team)) {
    victim function_78daa2c7f7c985b7("<dev string:x515>" + victim.team + "<dev string:x525>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(isDefined(takedown.victimanimnames) && (!isDefined(victim.animname) || !arraycontains(takedown.victimanimnames, victim.animname))) {
    victim function_78daa2c7f7c985b7("<dev string:x52c>" + (victim.animname ?? "<dev string:x540>") + "<dev string:x525>" + takedown.display_name + "<dev string:x408>", 1);

    return false;
  }

  if(istrue(takedown.trace)) {
    zoffset = (0, 0, 24);
    capsule = player getcollision("\x8b\x90\xb5\xc4W");
    playerradius = capsule.capsule_radius * 0.5;
    playerheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;

    if(isDefined(takedown.traceheight)) {
      zoffset = (0, 0, takedown.traceheight);
      playerheight = max(playerheight - takedown.traceheight * 2, playerradius * 2);
    }

    start = player.origin + zoffset;
    end = victim.var_39e5fb13996ec578.check_origin + zoffset;

    if(istrue(takedown.playerinwater)) {
      start = (start[0], start[1], end[2]);
    }

    trace = trace::capsule_trace(start, end, playerradius, playerheight, undefined, [player, victim], level.takedowns.collisioncontents);

    if(getdvarint(@ "hash_7cbf0b5da9c90d0e", 0)) {
      if(!isDefined(takedown.var_ee04ee9e09e057f3) || takedown.var_ee04ee9e09e057f3 < gettime()) {
        color = (1, 1, 1);
        duration = 1;

        if(getdvarint(@ "hash_a4c52236d240b4cd", 0)) {
          duration = 1000;
        }

        if(trace["<dev string:x54d>"] < 1) {
          color = (1, 0.25, 0.25);
        }

        trace::draw_trace(trace, color, 1, duration);
        takedown.var_ee04ee9e09e057f3 = gettime() + duration;
      }
    }

    if(trace["\xda\x16\x81\aw}^i"] < 1) {
      victim function_78daa2c7f7c985b7("<dev string:x559>" + takedown.display_name + "<dev string:x408>", 1);

      return false;
    } else if(istrue(takedown.playerinwater)) {
      start = player.origin + zoffset;
      end = (start[0], start[1], end[2]);
      trace = trace::capsule_trace(start, end, playerradius, playerheight, undefined, [player, victim], level.takedowns.collisioncontents);

      if(getdvarint(@ "hash_7cbf0b5da9c90d0e", 0)) {
        color = (1, 1, 1);
        duration = 1;

        if(getdvarint(@ "hash_a4c52236d240b4cd", 0)) {
          duration = 1000;
        }

        if(trace["<dev string:x54d>"] < 1) {
          color = (1, 0.25, 0.25);
        }

        trace::draw_trace(trace, color, 1, duration);
      }

      if(trace["\xda\x16\x81\aw}^i"] < 1) {
        victim function_78daa2c7f7c985b7("<dev string:x56b>" + takedown.display_name + "<dev string:x408>", 1);

        return false;
      }
    }
  }

  return true;
}

function function_5f82d22de6ee9aca(player) {
  assert(isPlayer(player));
  assert(!isPlayer(self));
  victim = self;

  if(!isDefined(victim.var_51e2a296052bd0f9) || victim.var_51e2a296052bd0f9 != gettime()) {
    victim.var_759a3baaee76a60d = 1;
    playerfwd = anglesToForward(player getplayerangles());
    playereye = player getEye();
    delta = victim getEye() - playereye;
    distclamp = clamp(distance(victim getEye(), playereye) - 30, 0, 120);
    dotcheck = 0.5 + 0.44 * distclamp / 120;

    if(vectordot(vectorNormalize(delta), playerfwd) < dotcheck) {
      victim.var_759a3baaee76a60d = 0;
    }

    victim.var_51e2a296052bd0f9 = gettime();
  }

  return victim.var_759a3baaee76a60d;
}

function function_2aebc9f488968b02(otherparticipant) {
  if(getdvarint(@ "hash_378e249d52f4898f")) {
    return 1;
  }

  if(isDefined(self.var_b22428bae0201298)) {
    funcsvalid = 1;

    foreach(func in self.var_b22428bae0201298) {
      if(!self[[func]](otherparticipant)) {
        function_78daa2c7f7c985b7("<dev string:x586>", 1);

        funcsvalid = 0;
        break;
      }
    }

    return funcsvalid;
  }

  return 1;
}

function function_7d5fb6e446365c88(player) {
  assert(isPlayer(player));
  assert(isactor(self));
  victim = self;

  if(istrue(player.takedown.force_silent) || istrue(player.takedown.nonlethal)) {
    return false;
  }

  return istrue(victim.bisincombat);
}

function function_c26d633d1b2eeaf7() {
  assert(isPlayer(self));
  player = self;

  if(isDefined(player.takedown.scene_root)) {
    return player.takedown.scene_root;
  }

  scene_root = spawnStruct();
  scene_root.origin = player.origin;
  scene_root.angles = player.angles;
  return scene_root;
}

function function_82808944f479d2c0(player, scene) {
  assert(isPlayer(player));
  assert(!isPlayer(self));
  victim = self;
  entid = victim getentitynumber();

  if(isDefined(player.takedown.scene_root)) {
    player.takedown.scene_root thread scene::cleanup(1);
  }

  player.takedown.scene_root = spawnStruct();
  scene_root = player.takedown.scene_root;

  if(isDefined(victim.takedown_origin)) {
    scene_root.origin = victim.takedown_origin;
  } else if(isDefined(player.takedown.edge_origin) && isDefined(player.takedown.edge_origin[entid])) {
    scene_root.origin = player.takedown.edge_origin[entid];
  } else {
    scene_root.origin = victim.origin;
  }

  if(isDefined(victim.takedown_angles)) {
    scene_root.angles = victim.takedown_angles;
  } else if(isDefined(player.takedown.edge_angles) && isDefined(player.takedown.edge_angles[entid])) {
    scene_root.angles = player.takedown.edge_angles[entid];
  } else {
    scene_root.angles = (0, vectortoyaw(scene_root.origin - player.origin), 0);
  }

  if(istrue(player.takedown.takedown.orienttovictimyaw)) {
    scene_root.angles = (scene_root.angles[0], scene_root.angles[1] + 180 - player.takedown.takedown.victimyaw, scene_root.angles[2]);
  }

  if(isDefined(scene) && !istrue(player.takedown.takedown.playerinwater)) {
    xanims = scene_root scene::function_979b54d9d4c16e5f(0, 0, scene);
    assert(!(!isDefined(xanims) || xanims.size <= 0));
    scene_root.origin -= player function_1209cad33e7b1211(getstartorigin(scene_root.origin, scene_root.angles, xanims[0]), victim);
  }

  return scene_root;
}

function private function_e8af8dbf25e3279c(scriptbundlename, victim) {
  player = self;
  assert(isstring(scriptbundlename));
  scene_root = victim function_82808944f479d2c0(player);
  player.takedown.takedown_xanims = scene_root scene::function_979b54d9d4c16e5f(0, 0, scriptbundlename);
  assert(!(!isDefined(player.takedown.takedown_xanims) || player.takedown.takedown_xanims.size <= 0));
  playerrig = namespace_6341d8b435bf1728::get_player_rig();
  playerrig stopanimScripted();
  targetorigin = getstartorigin(scene_root.origin, scene_root.angles, player.takedown.takedown_xanims[0]);
  playerrig.origin = targetorigin - player function_1209cad33e7b1211(targetorigin, victim);
  playerrig.angles = getstartangles(scene_root.origin, scene_root.angles, player.takedown.takedown_xanims[0]);
  playerrig setanimknob(player.takedown.takedown_xanims[0], 1, 0, 0);
  playerrig setanimtime(player.takedown.takedown_xanims[0], 0);
  playerrig dontinterpolate();
  acceldeceltime = 0.125;
  player playerlinktoblend(playerrig, "\xf6\xfc\xad\x9di\xb9)\xac/K", 0.25, acceldeceltime, acceldeceltime);
  playerrig hide(1);
}

function private function_1209cad33e7b1211(targetorigin, victim) {
  assert(isPlayer(self));
  player = self;

  setdvarifuninitialized(@ "hash_14eceba79fa8504a", 0);

  zoffset = 1;
  trace = trace::player_trace(player.takedown.start_origin, targetorigin, (0, 0, 0), [player, victim], level.takedowns.collisioncontents, undefined, zoffset);

  if(trace["\xda\x16\x81\aw}^i"] < 1) {
    offset = targetorigin - trace["1\xfd\x12\"\x9a\a\xf8\xb9\xbd\xf2\x16^\xb2M"];
    player.takedown.start_origin = trace["1\xfd\x12\"\x9a\a\xf8\xb9\xbd\xf2\x16^\xb2M"];

    if(getdvarint(@ "hash_14eceba79fa8504a", 0)) {
      duration = 2000;
      color = (0, 0, 1);
      sphere(victim.origin - offset, 5, color, 1, duration);
      color = (1, 0, 0);
      sphere(victim.origin, 5, color, 1, duration);
      color = (1, 1, 1);
      trace::draw_trace(trace, color, 1, duration);
    }
  }

  if(isDefined(offset)) {
    return offset;
  }

  return (0, 0, 0);
}

function private takedown_approach_update_loop(victim) {
  self notify("92\x13\xd8\x1c1c\x893\x1c\x9c\x99ll\xcc\x18");
  self endon("92\x13\xd8\x1c1c\x893\x1c\x9c\x99ll\xcc\x18");
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("K\x8c\xa9\xc3\xf0\xe0\x90~=\x0fw\xb7\"--\x8elc\xa8\xaa\xb2\x03V\xbf<F\xb0\xb2\x86");
  timeout = gettime() + 250;
  playerrig = namespace_6341d8b435bf1728::get_player_rig();

  while(gettime() < timeout) {
    waitframe();
    scene_root = victim function_82808944f479d2c0(player);
    assert(!(!isDefined(player.takedown.takedown_xanims) || player.takedown.takedown_xanims.size <= 0));
    targetorigin = getstartorigin(scene_root.origin, scene_root.angles, player.takedown.takedown_xanims[0]);
    playerrig.origin = targetorigin - player function_1209cad33e7b1211(targetorigin, victim);
    playerrig.angles = getstartangles(scene_root.origin, scene_root.angles, player.takedown.takedown_xanims[0]);
  }
}

function private takedown_monitor_hold_release() {
  self notify("*\xbe\xcf\x19\xb8t\x8a\xc7ud\\B@\xa0\x1f\xf6");
  self endon("*\xbe\xcf\x19\xb8t\x8a\xc7ud\\B@\xa0\x1f\xf6");
  self endon("\x80\x1d/\xaev\xfc\x14\xcc\xc0t*\x03Ll\x9a\xc3h\xb7T\x90\xb3\xd4.\xf7H\x89a\xd6Id\xca\xee\xfa");
  self.takedown.execute_now = 0;
  self waittill("X\xe3\x7f\xd8\x05jQ\xc8\x9c~\xaa\xa0\x9c4\"\xfc\xbe!\x93\x9c\xa1\nr");
  self.takedown.execute_now = 1;
}

function function_b567b456f8b58cfa(scene, player) {
  victim = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(utility::is_dead_or_dying(victim)) {
    player thread takedown_cleanup();
    return;
  }

  victim notify("\xafYgV\xa2`\xa2D\xa8\x96na\x99G7\x90-of");
  player utility::ent_flag_set("\xe2\r\x8b\xf5J\xdaM\t\xf8~\xe5w\x86\x1b\xf9");
  player.var_a9954958f4d0ca0b = victim;
  victim.og_maxsightdistsqrd = victim.maxsightdistsqrd;
  victim.og_newenemyreactiondistsq = victim.newenemyreactiondistsq;
  victim.og_battlechatter = victim.battlechatter;
  victim.og_allowdeath = victim.allowdeath;
  victim.allowantigrav = 0;
  victim.dontmelee = 1;
  victim.maxsightdistsqrd = 1;
  victim.fixednode = 0;
  victim.newenemyreactiondistsq = 0;
  victim.allowdeath = 0;
  victim.a.disablepain = 1;
  victim.allowpain = 0;
  victim.battlechatterallowed = 0;
  victim dialogue::stop_dialogue();
  victim.takedown_anim = scene;
  victim.remove_from_animloop = 1;
  victim.var_3aa831911040255c = 1;
  victim hudoutlinedisable();
  victim utility::ent_flag_set("\x89\xa9\xa85\xc3\xaeP:^~");
  victim utility::ent_flag_set("w\xc7\xe5\xd8\x84\x87\x9b\xac\xfbGF\x1b\xd4");
  victim ai::magic_bullet_shield();
  victim leaveinteraction();

  if(isDefined(level.cap) && isDefined(victim findoverridearchetype("\x8cP\xfc\xbc\xb5\x05\n\xfcp\xa3")) && isfunction(level.cap.fnexit)) {
    victim[[level.cap.fnexit]]();
    waittillframeend();
  }

  if(istrue(player.takedown.takedown.nonlethal) || istrue(player.takedown.takedown.playerinwater)) {
    victim utility_sp::disable_blood_pool();
  }

  victim notify("wm\x99\xb1\x9f,\x8c=u\x0ej\xdf?\x1e\bs3");

  if(isDefined(victim) || !utility::is_dead_or_dying(victim)) {
    complete_takedown = 1;

    if(player.takedown.start_demeanor != "+0a<s,") {
      waitframe();
      waitframe();
    }

    player val::set_array("s'\xf9\xd0J\x1e\x14u\xba\xa4\x0f,d|\xdd", level.takedowns.var_9a71c163c51b754f, 0);
    player val::set("s'\xf9\xd0J\x1e\x14u\xba\xa4\x0f,d|\xdd", "\x1c\xe3\x88@\x7f%G\x17\xef{V\xb1\xab\xb9t8", 0);
    player notify("\n,p\x0f\aG\xaf\xa7\x99\\\x17\xa51\xec\x817\xfc\xce\x8d\n\xe5K+\r\x16\xf4");
    player carrylinked::function_7a757fd6e145f22e();
    var_749d8198ded9d284 = player function_ca527233758eb9a8();

    if(isDefined(level.var_fac1b77431f3636a) && var_749d8198ded9d284) {
      if(getdvarint(@ "hash_3ee9189d52e605f8")) {
        iprintln("<dev string:x5a1>");
      }

      player notifyonplayercommand("X\xe3\x7f\xd8\x05jQ\xc8\x9c~\xaa\xa0\x9c4\"\xfc\xbe!\x93\x9c\xa1\nr", "\x96m+\xc6+\xb2}\xa7\xdeo\xb5");
      player function_e8af8dbf25e3279c(scene, victim);
      playerrig = namespace_6341d8b435bf1728::get_player_rig();
      playerrig stopanimScripted();
      playerrig hide(1);
      player childthread takedown_monitor_hold_release();
      player childthread takedown_approach_update_loop(victim);
      player forceplaygestureviewmodel("\xafAr\xfbh^)e'\xce\xdbP\xcf\xec\xc3\xfe\x05e\xc7\xc6z");

      if(!istrue(player.takedown.execute_now)) {
        player function_58d7a1890a68a3e8();

        if(getdvarint(@ "hash_3ee9189d52e605f8")) {
          iprintln("<dev string:x5c9>" + istrue(player.takedown.long_hold));
        }
      }

      player.takedown.execute_now = undefined;
      player.takedown.takedown_xanims = undefined;
      player notifyonplayercommandremove("X\xe3\x7f\xd8\x05jQ\xc8\x9c~\xaa\xa0\x9c4\"\xfc\xbe!\x93\x9c\xa1\nr", "\x96m+\xc6+\xb2}\xa7\xdeo\xb5");
      player notify("K\x8c\xa9\xc3\xf0\xe0\x90~=\x0fw\xb7\"--\x8elc\xa8\xaa\xb2\x03V\xbf<F\xb0\xb2\x86");
      player notify("\x80\x1d/\xaev\xfc\x14\xcc\xc0t*\x03Ll\x9a\xc3h\xb7T\x90\xb3\xd4.\xf7H\x89a\xd6Id\xca\xee\xfa");
      namespace_6341d8b435bf1728::unlink_player_from_rig();
      victim stopanimScripted();
      player function_4e6911887421e92e();
      player function_f59fbbad2226f9b6();
      player utility::delaythreadendon(0.75, "\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", &function_aac02915fcac0756, player.takedown.takedown, victim);

      if(istrue(player.takedown.long_hold)) {
        player val::reset_all("s'\xf9\xd0J\x1e\x14u\xba\xa4\x0f,d|\xdd");
        player cleanup_repulsor();
        scene = player.takedown.var_ecfd49546c4f9e70[0];
        scene_root = victim function_82808944f479d2c0(player, scene);
        player thread[[level.var_fac1b77431f3636a]](scene_root, victim);
        complete_takedown = 0;

        if(getdvarint(@ "hash_3ee9189d52e605f8")) {
          iprintln("<dev string:x5dd>" + scene);
        }
      }
    } else {
      if(getdvarint(@ "hash_3ee9189d52e605f8")) {
        iprintln("<dev string:x5ed>");
      }

      player forceplaygestureviewmodel("\xafAr\xfbh^)e'\xce\xdbP\xcf\xec\xc3\xfe\x05e\xc7\xc6z");
      playerrig = namespace_6341d8b435bf1728::get_player_rig();
      playerrig stopanimScripted();
      victim stopanimScripted();
      player function_4e6911887421e92e();
      player function_f59fbbad2226f9b6();
      player utility::delaythreadendon(0.75, "\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", &function_aac02915fcac0756, player.takedown.takedown, victim);
    }

    if(complete_takedown && !utility::is_dead_or_dying(victim)) {
      scene_root = victim function_82808944f479d2c0(player, scene);
      player childthread function_a081d67c31621a98(player);
      player childthread function_346db1cef010fd28(player);
      player childthread function_14512cdc0ba7de46(scene_root, victim);

      if(getdvarint(@ "hash_3ee9189d52e605f8")) {
        iprintln("<dev string:x60e>" + scene);
      }

      player childthread function_886b3ff73e261e62(scene_root, victim);
      player childthread function_c77c9e1dbf321232(scene_root);
      player thread function_f3bd737adad939dc(scene_root, victim);
      scene_root scene::play([player, victim], undefined, scene);

      if(!istrue(player.takedown.takedown.nodeath)) {
        takedown_death(victim);
      }
    }
  } else {
    if(getdvarint(@ "hash_3ee9189d52e605f8")) {
      iprintln("<dev string:x622>");
    }
  }

  player notify(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0", player.takedown.takedown);
  player thread takedown_cleanup();
}

function private function_58d7a1890a68a3e8() {
  self notify("\x8c\xc2\x8a\xd3\x03\xc8\xab\x0f\xb5\xef\xfe\x7f\x7f\xbb\xab\x88");
  self endon("\x8c\xc2\x8a\xd3\x03\xc8\xab\x0f\xb5\xef\xfe\x7f\x7f\xbb\xab\x88");
  self endon("X\xe3\x7f\xd8\x05jQ\xc8\x9c~\xaa\xa0\x9c4\"\xfc\xbe!\x93\x9c\xa1\nr");
  self endon("\x06P\xd0\xcf\xe4Q\xec\xbe\x85d\x93\xe3\a?\b=\x8c\\\xe0\x86\xbc>(3\x89E\x11\xbf\xa7\a\xe0\xd2\xc3\xcf\x15\xbc");
  wait 0.4;
}

function private function_aac02915fcac0756(takedown, victim) {
  player = self;
  assert(isPlayer(player));
  assert(isent(victim));
  eventtype = istrue(player.takedown.takedown.nodeath) ? "5\xba\x8fe\xc3ze\xabn\xaf\xf6\\" : "Y5\x90\xb5\xa1\xb3\x91\xa0\x8c'\\";

  if(isDefined(victim.stealth)) {
    if(takedown.overridedamagesightrange > 0) {
      victim.stealth.override_damage_sight_range = takedown.overridedamagesightrange;
    }

    victim utility::function_dad7b074713963f6(eventtype, player, "\xdc\xd8r\xd28\x1d+\x91\xf5\xb6elY\xac");
  }
}

function private function_f3bd737adad939dc(scene_root, victim) {
  self notify("\x15dx\x19\xac\x92\xcf[\xf3\xbe=\x02\x1a\xfc\xe3\x94");
  self endon("\x15dx\x19\xac\x92\xcf[\xf3\xbe=\x02\x1a\xfc\xe3\x94");
  player = self;
  assert(isPlayer(player));
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_8d1e2aad4c97d73a = victim.var_90ed0de999f7f413;
  waitframe();
  player utility::function_18e9f1084badc1c7("Yj\xd3mH4\xc3\xb5\x80zq\xc6");
  player val::reset_all("s'\xf9\xd0J\x1e\x14u\xba\xa4\x0f,d|\xdd");
  player stopgestureviewmodel("\xafAr\xfbh^)e'\xce\xdbP\xcf\xec\xc3\xfe\x05e\xc7\xc6z");

  if(player.takedown.takedown.playerinwater) {
    trace = trace::ray_trace(player.takedown.start_origin, player.origin, [player, victim], level.takedowns.collisioncontents);

    if(trace["\xda\x16\x81\aw}^i"] < 1) {
      if(getdvarint(@ "hash_3ee9189d52e605f8", 0)) {
        color = (1, 1, 1);
        sphere(trace["<dev string:x636>"], 5, color, 1, 1000);
      }

      player setOrigin(trace["\xc1\xbd\xdci\xe8i{7"]);
    }
  }

  player player_sp::function_a9a4c8a5f556afa7(player.takedown.start_origin, 0, [player, victim], level.takedowns.collisioncontents);
  level thread callback::callback(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0", {
    #var_90ed0de999f7f413: var_8d1e2aad4c97d73a, #victim: victim, #player: player, #takedown: player.takedown.takedown
  });
  player cleanup_repulsor();
  level callback::callback(#"hash_6c71d319dc089c27", {
    #event: #"hash_bfeb6496736df3a2"});
  player thread player_sp::regeneratehealth();
  player thread carrylinked::wait_to_revert_demeanor("\xafAr\xfbh^)e'\xce\xdbP\xcf\xec\xc3\xfe\x05e\xc7\xc6z");
}

function private function_886b3ff73e261e62(scene_root, victim) {
  self notify("\xd4\x8es\xb3j\xefr\xf4\xaa\xb0\xfb\xcch\x8a\x10!");
  self endon("\xd4\x8es\xb3j\xefr\xf4\xaa\xb0\xfb\xcch\x8a\x10!");
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("|\xf3\x81\x8e\xa9\xe2W\x94\x94\xd6\"\xdcn8:\xac\xacC\x05\xff");
  player endon(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0");
  scene_root scene::function_993ae53c5ec4240b(victim, "U\x17\x1b\xb3\x9d+N\x18", "\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0");
  victim waittill("U\x17\x1b\xb3\x9d+N\x18");

  if(!istrue(player.takedown.takedown.nodeath)) {
    takedown_death(victim);
  }
}

function private function_c77c9e1dbf321232(scene_root) {
  self notify("\xc8(\x11\xf1\xa4?m\xbb\a\xdd\"1\xb4\xb9\xd4\x1c");
  self endon("\xc8(\x11\xf1\xa4?m\xbb\a\xdd\"1\xb4\xb9\xd4\x1c");
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("|\xf3\x81\x8e\xa9\xe2W\x94\x94\xd6\"\xdcn8:\xac\xacC\x05\xff");
  player endon(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0");

  while(true) {
    player waittill("U\x04\xf0\x1f\xbbX}\x14\xfa", prop_name, hide_prop);

    if(isDefined(scene_root.scenedata.sceneobjectdata) && isDefined(scene_root.scenedata) && isDefined(scene_root) && isDefined(prop_name)) {
      foreach(obj in scene_root.scenedata.sceneobjectdata) {
        if(isent(obj.entity) && obj.entity.model == prop_name) {
          if(isDefined(hide_prop)) {
            obj.entity hide(1);
          } else {
            obj.entity show();
          }

          break;
        }
      }
    }
  }
}

function private function_14512cdc0ba7de46(scene_root, victim) {
  self notify("x\xa2Z\xdf\x98\xe3\x15z\x865\xad\xbaz\xc4(\x01");
  self endon("x\xa2Z\xdf\x98\xe3\x15z\x865\xad\xbaz\xc4(\x01");
  player = level.player;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("|\xf3\x81\x8e\xa9\xe2W\x94\x94\xd6\"\xdcn8:\xac\xacC\x05\xff");
  player endon(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0");
  var_6a65c1941177b623 = "A\x04\xfeL\x80\x8e\x9fO\x98~\xefI\xda\xd8ZBz\x873";
  scene_root scene::function_993ae53c5ec4240b(player, var_6a65c1941177b623, "\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0");
  player waittill(var_6a65c1941177b623);
  xanims = scene_root scene::function_979b54d9d4c16e5f("iN\xf2\xb2\xdb\xf5", 0);

  if(!isDefined(xanims) || xanims.size <= 0) {
    return;
  }

  victim anim_sp::function_82ecf17b8bd03eff(scene_root.origin, scene_root.angles, xanims[0], ["\xc1\xaf\x82\xc1\t\xf9", "*\x11\x9f\xb9!()w%\xd1", "4\xac\x01\xc2\xc9A\x93<\x91\x8c"], [player, victim], 5, level.takedowns.collisioncontents, "\xd5\x18sO\x17\x1c\xe5\x15\xd2pA&");
}

function takedown_allow_melee(enabled) {
  player = self;

  if(!istrue(enabled) || player getstance() == "GX\xa9]\x82") {
    player val::set("\xae\xa2\xe5E\xaeN\xf5]\xd3\x06{\xa7bV\xb7\x98\xc8\xc7\x8f\xa8", "mV\x8d+e", 0);
    return;
  }

  player val::reset("\xae\xa2\xe5E\xaeN\xf5]\xd3\x06{\xa7bV\xb7\x98\xc8\xc7\x8f\xa8", "mV\x8d+e");
}

function takedown_death(victim) {
  if(!isent(victim) || !isalive(victim)) {
    return;
  }

  player = level.player;
  victim.skipdeathanim = 1;
  victim.noragdoll = 1;
  victim pushplayer(0);
  victim.allowdeath = 1;
  victim.var_5061aef10be4384a = 1;

  if(isDefined(victim.magic_bullet_shield)) {
    victim ai::stop_magic_bullet_shield();
  }

  victim val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");

  if(!utility::is_dead_or_dying(victim)) {
    victim kill((0, 0, 0), player, player, "\x13\x1e\xe31{\xb4\xf1\x85\x18");
  }

  if(!istrue(victim.takedown_ragdoll) && isDefined(player.takedown) && isDefined(victim.origin)) {
    player.takedown.kill_origin = victim.origin;
  }
}

function takedown_ragdoll(victim) {
  player = level.player;

  if(!isDefined(victim) && isDefined(player.takedown.kill_origin)) {
    foreach(corpse in getcorpsearray(player.origin, 500)) {
      if(istrue(corpse.takedown_ragdoll)) {
        continue;
      }

      if(corpse isragdoll()) {
        continue;
      }

      corpseorigin = corpse utility_sp::get_corpse_origin();

      if(isDefined(corpseorigin) && distancesquared(corpseorigin, player.takedown.kill_origin) < squared(60)) {
        corpse startragdoll();
        corpse.takedown_ragdoll = 1;
      }
    }
  } else if(isDefined(victim) && !istrue(victim.takedown_ragdoll)) {
    if(isai(victim)) {}

    victim startragdoll();
    victim.takedown_ragdoll = 1;
  }

  player.takedown.kill_origin = undefined;
}

function function_f20b54d9e71264d0(player) {
  victim = self;
  now = gettime();

  if((victim.var_25297b9b88857314 ?? -1) != now) {
    if(!isDefined(victim.var_39e5fb13996ec578)) {
      victim.var_39e5fb13996ec578 = spawnStruct();
    }

    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
    tagangles = victim gettagangles(tag);
    tagpos = victim gettagorigin(tag);
    tagright = anglestoright(tagangles);
    tagfwd = anglesToForward(tagangles);
    var_99f26eed70afe221 = player.origin - tagpos;
    var_99f26eed70afe221 = (var_99f26eed70afe221[0], var_99f26eed70afe221[1], 0);
    var_99f26eed70afe221 = vectorNormalize(var_99f26eed70afe221);
    dotup = abs(vectordot(tagfwd, (0, 0, 1)));

    if(dotup > 0.7) {
      tagfwd = vectorNormalize((tagright[0], tagright[1], 0));
    } else {
      tagfwd = vectorNormalize((tagfwd[0], tagfwd[1], 0));
    }

    entfwd = anglesToForward(victim.angles);

    if(vectordot(var_99f26eed70afe221, entfwd) > vectordot(tagfwd, entfwd)) {
      tagfwd = entfwd;
    }

    tagright = vectorcross(tagfwd, (0, 0, 1));
    victim.var_39e5fb13996ec578.var_719e4f79192bc109 = var_99f26eed70afe221;
    victim.var_39e5fb13996ec578.dot_forward = vectordot(tagfwd, var_99f26eed70afe221);
    victim.var_39e5fb13996ec578.dot_right = vectordot(tagright, var_99f26eed70afe221);
    victim.var_39e5fb13996ec578.height = victim.origin[2] - player.origin[2];
    victim.var_39e5fb13996ec578.height_abs = abs(victim.var_39e5fb13996ec578.height);
    victim.var_39e5fb13996ec578.check_origin = tagpos;
    victim.var_39e5fb13996ec578.var_72ea832e65c46f34 = victim gettagorigin("\x13'$\xc4\xf8l\x16\xdf", 1) ?? (tagpos[0], tagpos[1], tagpos[2] + 40);
    victim.var_39e5fb13996ec578.distsq = distancesquared(victim.var_39e5fb13996ec578.check_origin, player getEye());
    victim.var_39e5fb13996ec578.facing_yaw = player function_abffaeea8ed0ed33(victim);
    victim.var_39e5fb13996ec578.var_68c4d15c091b1d66 = abs(angleclamp180(vectortopitch(victim.var_39e5fb13996ec578.var_72ea832e65c46f34 - player getEye())) - player getplayerangles()[0]);
    victim.var_25297b9b88857314 = now;
  }

  return victim.var_39e5fb13996ec578;
}

function function_abffaeea8ed0ed33(victim) {
  player = self;
  dir = player function_2af7fe550c3c2202(victim);
  dir_2d = vectorNormalize((dir[0], dir[1], 0));

  if(vectordot(dir_2d, anglesToForward((0, player getplayerangles()[1], 0))) < 0.866) {
    return false;
  }

  return true;
}

function private function_637fb15965573e95(takedown, scene, tags) {
  assert(isarray(tags));

  if(tags.size > 0) {
    if(isDefined(takedown.scene_tags[scene])) {
      foreach(scenetag in takedown.scene_tags[scene]) {
        if(istrue(tags[scenetag])) {
          return false;
        }
      }
    }
  }

  return true;
}

function private function_5331a3fa2b669008() {
  if(!isDefined(level.stealth)) {
    return false;
  }

  assert(isPlayer(self));
  ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  combatcount = 0;
  stealthcount = 0;

  foreach(guy in ais) {
    if(isent(guy) && !utility::is_dead_or_dying(guy)) {
      if(istrue(guy.bisincombat)) {
        combatcount++;

        if(combatcount > 1) {
          return false;
        }

        continue;
      }

      stealthcount++;
    }
  }

  return stealthcount > 0;
}

function private function_4c793df85c7198e5() {
  if(function_5331a3fa2b669008()) {
    return "\x13\\\x8f\xf4";
  }

  return undefined;
}

function private function_a71d07c6de33b796() {
  var_8df0ee3f919408c3 = [];

  foreach(tagtest in level.scenetagtests) {
    tag = self[[tagtest]]();

    if(isDefined(tag)) {
      var_8df0ee3f919408c3[tag] = 1;
    }
  }

  return var_8df0ee3f919408c3;
}

function function_32c76f8ed79daada(takedown) {
  assert(isPlayer(self));
  assert(isDefined(takedown.scenes));
  player = self;

  if(!isDefined(player.takedown.scene_deck)) {
    player.takedown.scene_deck = [];
  }

  if(!isDefined(player.takedown.scene_deck[takedown.name])) {
    player.takedown.scene_deck[takedown.name] = utility::create_deck(takedown.scenes, 1, 1, 1);
  }

  return player.takedown.scene_deck[takedown.name];
}

function takedown_cleanup(var_fd858f2baa6369c7) {
  assert(isPlayer(self));
  player = self;
  player notify("\x87\xa7\xae\x96\xc6\xe11k'&\xc5k\x96\x80C\xb5");
  player endon("\x87\xa7\xae\x96\xc6\xe11k'&\xc5k\x96\x80C\xb5");
  player function_4e6911887421e92e();
  player function_f59fbbad2226f9b6();
  player function_fa0ae9e347b5d1ee();
  deck = player function_32c76f8ed79daada(player.takedown.takedown);
  deck utility::deck_draw();

  if(isDefined(var_fd858f2baa6369c7)) {
    if(!isarray(var_fd858f2baa6369c7)) {
      var_fd858f2baa6369c7 = [var_fd858f2baa6369c7];
    }

    player waittill(var_fd858f2baa6369c7);
  }

  player val::reset_all("y\x9e\xfa\xb1\x95.\x839");

  if(isalive(player.var_a9954958f4d0ca0b) && !istrue(player.var_a9954958f4d0ca0b.takedown_live) && !istrue(player.takedown.long_hold)) {
    if(isDefined(player.var_a9954958f4d0ca0b.magic_bullet_shield)) {
      player.var_a9954958f4d0ca0b ai::stop_magic_bullet_shield();
    }

    player.var_a9954958f4d0ca0b stopanimScripted();
    player.var_a9954958f4d0ca0b val::reset("y\x9e\xfa\xb1\x95.\x839", "\xdc\xf6n\xbe\x91\xb2ce\xe8\v&\xd8\xca");
    player.var_a9954958f4d0ca0b kill(player.origin, player, player, "\x13\x1e\xe31{\xb4\xf1\x85\x18");
    player.var_a9954958f4d0ca0b = undefined;
  }

  player.in_melee_death = undefined;
  player.takedown.long_hold = undefined;
  player cleanup_repulsor();
  player utility::ent_flag_clear("\xe2\r\x8b\xf5J\xdaM\t\xf8~\xe5w\x86\x1b\xf9");
  player clearsoundsubmix("s\xe0\xfa\x8e\x89\xc0_\x8e,\xd6+\x91\xedw\xb9", 0.2);
}

function private cleanup_repulsor() {
  if(istrue(self.takedown.var_465d9063611f1221)) {
    destroynavrepulsor("y\x9e\xfa\xb1\x95.\x839");
    self.takedown.var_465d9063611f1221 = undefined;
  }
}

function function_a6205a5dd6ff9a6d(new_victim, doing_takedown) {
  player = self;

  if(isDefined(new_victim) && (!isDefined(player.takedown.victim) || player.takedown.victim != new_victim)) {
    player thread namespace_5a0f99556b0f68f7::stealth_noteworthy_delayed("y\x9e\xfa\xb1\x95.\x839", new_victim, undefined, 0.2);
  }

  player.takedown.victim = new_victim;
}

function private function_78daa2c7f7c985b7(msg, failure) {
  if(!getdvarint(@ "hash_3ee9189d52e605f8", 0) || !isDefined(msg)) {
    return;
  }

  if(!isDefined(self.var_82e4e7aac40ad037) || gettime() > self.var_82e4e7aac40ad037) {
    self.var_82e4e7aac40ad037 = gettime();
    self.takedown_debug = [];
  }

  foreach(existing in self.takedown_debug) {
    if(existing.msg == msg) {
      return;
    }
  }

  entry = spawnStruct();
  entry.failure = failure;
  entry.msg = msg;
  self.takedown_debug[self.takedown_debug.size] = entry;
  thread function_8b9f1ab744d87d82();

  if(isPlayer(self)) {}
}

function private function_8b9f1ab744d87d82() {
  self notify("<dev string:x642>");
  self endon("<dev string:x642>");
  self endon("<dev string:x65c>");
  waittillframeend();

  if(isPlayer(self)) {
    if(isDefined(self.var_b269d2efb221e01c)) {
      foreach(elem in self.var_b269d2efb221e01c) {
        elem destroy();
      }
    }

    self.var_b269d2efb221e01c = [];

    if(!istrue(level.player.takedown.debug.enabled)) {
      return;
    }

    y = 80;

    foreach(entry in self.takedown_debug) {
      color = (1, 1, 1);

      if(isDefined(entry.failure) && entry.failure == 1) {
        color = (1, 0, 0);
      }

      if(isDefined(entry.failure) && entry.failure == 2) {
        color = (0.5, 0.5, 0.5);
      }

      textelem = newhudelem();
      textelem.x = 0;
      textelem.y = y;
      textelem.alignx = "<dev string:x665>";
      textelem.aligny = "<dev string:x66d>";
      textelem.font = "<dev string:x674>";
      textelem.fontscale = 0.75;
      textelem.alpha = 1;
      textelem setdevtext(entry.msg);
      textelem.color = color;
      y += 10;
      self.var_b269d2efb221e01c[self.var_b269d2efb221e01c.size] = textelem;
    }

    return;
  }

  if(!istrue(level.player.takedown.debug.enabled)) {
    return;
  }

  y = 40;

  foreach(entry in self.takedown_debug) {
    color = (1, 1, 1);

    if(isDefined(entry.failure) && entry.failure == 1) {
      color = (1, 0, 0);
    }

    if(isDefined(entry.failure) && entry.failure == 2) {
      color = (0.5, 0.5, 0.5);
    }

    print3d(self.origin + (0, 0, y), entry.msg, color, 1, 0.1, 1, 0);
    y -= 3;
  }
}

function function_a081d67c31621a98(player) {
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("Y\x82\xc8\xdb\xa0\xe3P\x99x\xf7\xca");
  self endon("Y\x82\xc8\xdb\xa0\xe3P\x99x\xf7\xca");
  self.watching = 1;
  self waittill("V([\xf3\xb7\xed\xb7s\xe7/\xd1N\xda\xc1\xb0\"\x8c\x1d=\xbb");
  snd::transient_load("\bUM\x87\xe8v=\xd2\x1e\x03\xe93\xb9\xc0f\xa3\x14\x17\xfd\xab\xba\xf3D'<");
  underwater = level.player isswimunderwater();

  if(self.watching == 1 && !underwater) {
    self setentitysoundcontext("\xe4\xf1G", "\xb8\"");
    self setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "");
  } else if(self.watching == 1 && underwater) {
    self setentitysoundcontext("\xe4\xf1G", "\xb8\"");
    self setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "p\x93\x8f5O\xdfNV\x14\xca");
  }

  thread function_a4cfd53ac5efd99e();

  while(self.watching == 1) {
    self waittill("0\xe7\xa7\x8c\xf2\xb4\xbdEp%\x90\xfc\xf1\x87\xc7\x9b\x99\x87\x13E");
    self setsoundsubmix("9\xa1M\xdbkhP\xdby\xd4\xcaQ\xb2I*\xb8]\x8a\b\xd3\x10\xf7Q\x19\xf9\xf0\xd6");
    self function_bc7d71d1b2d21a0f("\x8ac\x84\xdcKM\x16\fE\xfc\xb0\x95G\x87\xf8t\x8f\x90uj6", 1);
    thread function_d3c66dec10405ea();
  }
}

function function_d3c66dec10405ea() {
  self notify("\x91\xb9\xc85\xab\xaeD\x16N");
  self endon("\x91\xb9\xc85\xab\xaeD\x16N");
  wait 2;
  self setentitysoundcontext("\xe4\xf1G", "");
  thread function_ebabc5454a0ded34();
}

function function_ebabc5454a0ded34() {
  self notify("$\xa5\x86\x05wm+\v-P\x87#\x83");
  self endon("$\xa5\x86\x05wm+\v-P\x87#\x83");
  utility::waittill_any_timeout(5, "I\x02\xfc\xc0Z\xa2g\x85\xa57\x93\x99\xc8\xc6\xa3\v1~E[\xbc\xf7");
  self clearsoundsubmix("9\xa1M\xdbkhP\xdby\xd4\xcaQ\xb2I*\xb8]\x8a\b\xd3\x10\xf7Q\x19\xf9\xf0\xd6");
  snd::transient_unload("\bUM\x87\xe8v=\xd2\x1e\x03\xe93\xb9\xc0f\xa3\x14\x17\xfd\xab\xba\xf3D'<");
  snd::transient_unload("\xe0\xff\xca\x05\a{\xfb\xa0A\xab\xf2\x16Ls\x95&\x9aQAp\xf4<\xbe@`\xea");
}

function function_a4cfd53ac5efd99e() {
  self waittill("I\x02\xfc\xc0Z\xa2g\x85\xa57\x93\x99\xc8\xc6\xa3\v1~E[\xbc\xf7");
  self.watching = 0;
}

function function_346db1cef010fd28(player) {
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("\x90\xad\x14S1\x81\x9d9\x8a\xa7\nq");
  self endon("\x90\xad\x14S1\x81\x9d9\x8a\xa7\nq");
  self.watching = 1;
  self waittill("\xcf5\xc8\x99\x18BV\xa90~t`\x11\x88\xd5\x9c\x16\x9d\xe8\xa58");
  snd::transient_load("\xe0\xff\xca\x05\a{\xfb\xa0A\xab\xf2\x16Ls\x95&\x9aQAp\xf4<\xbe@`\xea");

  if(self.watching == 1) {
    self setentitysoundcontext("\xe4\xf1G", "\xb8\"");
  }

  thread function_91cb9a105cf32c82();

  while(self.watching == 1) {
    self waittill("k\xf2Om\xf8\r\xa7\x15\x7f\xcb\xb4\xd8\xad\x17+\xa0\xb6*\x9f\x1e8");
    self setsoundsubmix("9\xa1M\xdbkhP\xdby\xd4\xcaQ\xb2I*\xb8]\x8a\b\xd3\x10\xf7Q\x19\xf9\xf0\xd6");
    self function_bc7d71d1b2d21a0f("?Gt/\xceT\x81\xd14~K\x1f\xb7\xf7\x14+\xfeS\x96$\xf2\x0f\fOp\xb1\xde\xf4\r\xee#\xcf\xe5\x15\xed\xce\x9e", 1);
    thread function_d3c66dec10405ea();
  }
}

function function_91cb9a105cf32c82() {
  self waittill("I\x02\xfc\xc0Z\xa2g\x85\xa57\x93\x99\xc8\xc6\xa3\v1~E[\xbc\xf7");
  self.watching = 0;
}