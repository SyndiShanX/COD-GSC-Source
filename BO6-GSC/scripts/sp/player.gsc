/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player.gsc
**************************************/

#using scripts\common\callbacks;
#using scripts\common\damage;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_tracking;
#using scripts\common\whizby;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\audio;
#using scripts\sp\equipment\offhands;
#using scripts\sp\gameskill;
#using scripts\sp\heartbeat_sp;
#using scripts\sp\loot;
#using scripts\sp\player\edgehang;
#using scripts\sp\player\gestures;
#using scripts\sp\player_rig;
#using scripts\sp\player_stats;
#using scripts\sp\swim_sp;
#using scripts\sp\utility;
#namespace player_sp;

function init() {
  if(!utility::add_init_script("e \xcb\xd7\x9d,\xcfNb\x8d\xcb0", &init)) {
    return;
  }

  val::register("g\x8civ\xc7\xe0v\xdb\x14\f\xc8\x93\x16\xf2\x9c\v", 0, 1, "\x127\xca\x8d3", &function_3663892b2bd03aa6, "~\xa9\xccdcE");
  val::register("\a\x85\xb4\xe6\xf5\x9d-\xcd\xd2{\xdc", 0, 1, "\x127\xca\x8d3", &function_1b0a489a18329651, "~\xa9\xccdcE");
  initplayerdvars();
  initplayervfx();
  initplayerprecache();
  callback::callback(#"register_fullscreenfx", spawnStruct());
  assert(isDefined(level.var_5d5a8dba0f6b0275), "<dev string:x24>" + (isDefined(level.gamemodebundle.fullscreenfxtechnique) ? getxhashsourcename(level.gamemodebundle.fullscreenfxtechnique) : "<dev string:x4a>"));
  var_8b45a84a29c1a8ff = level.sharedfuncs[#"fullscreenfx"][#"hash_967b2afe3d37405"];

  if(isDefined(var_8b45a84a29c1a8ff)) {
    self[[var_8b45a84a29c1a8ff]]();
  }

  level.players = getEntArray("K_p\x84a\x01", #classname);
  level.player = level.players[0];
  level.player.lastenemykilltime = 0;
  level.player.lastenemydmgtime = 0;
  level.player.deathshieldfunc = &deathshieldfunc;
  level.player.gs = spawnStruct();
  level.player.gs.scripteddamagemultiplier = 1;
  level.player.gs.scripteddeathshielddurationscale = 1;
  level.player.gs.var_9a45caab4d484b5 = 1;
  level.player.gs.var_8c2fe6dcd2893a1a = 1;
  level.player.gs.basehealthdamagemultiplier = 1;
  level.player.gs.basehealthexplosivedamagemultiplier = 1;
  level.player.maxhealth = 100;
  level.player.health = 100;
  level.player.lasthealth = 100;
  level.player.var_34a1298708ca48f0 = 0.7;
  level.player.pers = [];
  level.player initplayerdefaultsettings();
  level.player initplayeromnvars();
  level.player initplayernotifies();
  level.player initplayerentflags();
  level.player initplayerdamage();
  level.player initplayerfocus();
  level.player initplayerfoley();
  level.player function_2bfd11246a9abf97();
  level.player thread hud_think();
  level.player thread ladderpistol();
  level.player thread edgehang::edgehang();
  level.player thread watchweaponswap();
  level.player thread function_81dc3283a7a53c94();
  level.player thread function_b6d288653605d48c();
  level.player thread armorplateprestream();

  if(istrue(level.var_9940311072c92946)) {
    thread utility_sp::function_10cbed9fdc811059();
  }

  setdvarifuninitialized(@ "hash_92edcd4e782939e5", 1);
  level.player thread gestures::function_a1e7ea89c16073eb();

  if(isDefined(level.gamemodebundle.var_92d870ce553f402)) {
    setsaveddvar(@ "hash_4bdbfc1e7f0ba01b", level.gamemodebundle.var_92d870ce553f402);
  }

  if(!istrue(level.gamemodebundle.var_680f89aded00ff7f)) {
    level.player thread gestures::function_5137bf0e8403f1e8();
  }

  if(isDefined(level.gamemodebundle.var_e038f2cf7d7b042f)) {
    setsaveddvar(@ "hash_ef6d442fd15e373a", level.gamemodebundle.var_e038f2cf7d7b042f);
  }

  utility_sp::post_load_precache(&playerpostload);
  level.callbackplayerdamage = &onplayerdamaged;
  level thread function_160c1fa58ff3b784();

  level thread function_bca1b32459e6f60c();

  level.player thread debugweaponattachments();
}

function private function_160c1fa58ff3b784() {
  self notify("\xe6<l}\x991t\xe2\x7f4\r/}+\xfdY");
  self endon("\xe6<l}\x991t\xe2\x7f4\r/}+\xfdY");
  utility::flag_wait("p\xdb\xf4\x85c\xa0e\xbe\xcbn\x8a\xcd\x858\x96\xca5");

  while(true) {
    if(isDefined(level.player)) {
      vehicles = vehicle_tracking::function_b13adb567a462010();

      if(isDefined(vehicles) && vehicles.size > 0) {
        vehicle_interact::update_player_usability(level.player, vehicles);
      }
    }

    waitframe();
  }
}

function codecallback_playerdamage(damage, attacker, inflictor, direction, point, type, partname, objweapon, shitloc, timeoffset, dflags, dist) {
  [[level.callbackplayerdamage]](damage, attacker, inflictor, direction, point, type, partname, objweapon, shitloc, timeoffset, dflags, dist);
  self.lasthealth = self.health;
}

function private onplayerdamaged(damage, attacker, inflictor, direction, point, type, partname, objweapon, shitloc, timeoffset, dflags, dist) {
  player = self;
  player.hadarmor = hasarmor();

  if(!isalive(player)) {
    player thread ondeathfinalhit(attacker, type, damage);
    return;
  }

  if(!isDefined(point)) {
    point = player.origin;
  }

  player.dmgtoplayer = damage;
  player.dmgpoint = point;
  player dispersedamage(player.damage.disperse, damage, attacker, direction, point, type, objweapon, inflictor, dflags);

  if(getdvarint(@ "hash_c171156c4fe8b9fc", 0) != 0) {
    damagescore = damage::scoredamage(inflictor, attacker, self.damage.healthdamage, dflags, type, dist, objweapon, point, direction, shitloc, self.damage.lightarmordamage, 0);
    player postplayerdamage(inflictor, attacker, self.damage.healthdamage, dflags, type, objweapon, point, direction, shitloc, timeoffset, partname, self.damage.lightarmordamage, dist, damagescore);
  }

  thread analytics::analytics_playerdamage(attacker, objweapon, damage, type, partname);
  maintainhealthfloor();
}

function calldamagefunctions(functionsfunc, damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  self endon("\x1e\xfd\xd1\xa2\a");

  foreach(function in [[functionsfunc]](type)) {
    self childthread[[function]](damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage);
  }

  foreach(function in self.damage_functions) {
    self childthread[[function]](damage, attacker, direction, point, type, overkilldamage, inflictor);
  }
}

function playerpostload() {
  level.player thread swim_sp::function_62e0856d3e744483();
  level.player thread heartbeat_sp::function_201d919eac18da03();
  level.player thread objectives::function_db1a8c8d97b93be();
}

function deathshieldfunc(bool) {
  if(utility::damageflag(2) && !utility::damageflag(1)) {
    self enabledeathshield(bool);
  }
}

function main() {
  utility_sp::add_hint_string("\xce\x9d\xa1E\xe8P\xdf\x97\ri", &"game/focus_hint", &focus_held_down);
  level.player playerdamagemain();
  level.player playeroffhandmain();
  level.player playeraltweapon();
  level.player playerfocusmain();
  level.player thread utility_sp::playerwatch_unresolved_collision();

  level.player thread function_212dadfe65a3af0c();
  level.player thread function_18997e7465f45cc6();
}

function function_2bfd11246a9abf97() {
  if(isDefined(level.gamemodebundle.var_c40b43b635f79e78)) {
    climbfists = getscriptbundlefieldvalue(level.gamemodebundle.var_c40b43b635f79e78, #"asset");
    self.climbfists = utility_sp::make_weapon(climbfists);
    utility_sp::give_weapon(self.climbfists);
  }

  if(isDefined(level.gamemodebundle.defaultswimweapon)) {
    swimweapon = getscriptbundlefieldvalue(level.gamemodebundle.defaultswimweapon, #"ref") + "\x97\xeb4";
    self.swimweapon = utility_sp::make_weapon(swimweapon);
  }
}

function initplayerdvars() {
  setdvarifuninitialized(@ "hash_bfa6bedc37206c58", 1);
  level.var_efdb5f20c72d3104 = 1;
  setsaveddvar(@ "bg_falldamagemaxheight", 375);
  setsaveddvar(@ "bg_falldamageminheight", 220);
  setsaveddvar(@ "g_speed", 150);
  setsaveddvar(@ "hash_ecd52993b5dab130", 75);
  setDvar(@ "hash_c815d5683eea5b67", 0);
  setsaveddvar(@ "cg_crosshairenemycolor", 0);
  setsaveddvar(@ "hash_f7da54a18841a6f8", 30);
  setdvarifuninitialized(@ "hash_e7c074c9ef3fd481", 0);
}

function initplayervfx() {
  level.g_effect["i\x8bo\xa6\xae\xf7\xce~\xce\x98g`\xcbb\x12)\xd2\xf4\xa6\xc1"] = loadfxasset("m\xb7D\xbd\xa2\xd48\xf5\xcb\xa3Q\xdd\x05\x8d\xf1\x15\n\xfc\xf0\xf2\xf2$\x82\xc5\x81\x994\x8f\vU\x82av");
  level.g_effect["\x93LO\x82\x1fe\xc1 \x1c\xa8~;#\xef}\x92nf\xf6\x80\xf3m\xa8Q "] = loadfxasset("\tv\xb1\x1c\x98p\x10G\x83@\xbe\xb8\x1b\x02\x82\x93\x92/.\xbb\x93\xae}\xe1\xfc\xb7\x8fe\xd0(\x88\x96S>Q\xd7\xdbe");
  level.g_effect["u\xf6'0\x8er\x1f>Q-)\xde6\xbe\x96\xc2\x10I\x87"] = loadfxasset("\x8e\xa5\xc3\x11j\xf3\xd7\xf8C#n\xa3\xca\xa29\xdd\xb9\xa7\xadrQ;)\x87.\xbe\xfe\x9d\x03f\x13\xb3");
  level.g_effect["\xce\xa6\x8e\xce\xed%\xe8\xd2\x96\xae\x114\bE}:\xec"] = loadfxasset("w\xfd\xf0\xc0\x97\xe75y\xbe>\\(\x9cP\x8b\x1c\x96W\x92'xW\xaf\xb6Q/\tV\x02&");
  level.g_effect["\x1c\xc6\xb0\xf2V'\xd7\xf6n\xccZ\x93e\xeb\x1b,'g\xac"] = loadfxasset("\x9b\xb3V\x9dD\xc4\x95\xde\xb6\xf3l\xc3\xf1\xab\x87MX\b4\xfa\x9e\x11\xbb\x82#\xc9\xc4\xb2\xcb\xbf\x90%");
  level.g_effect["\xcf\x8b\xf8\xcd\xbd\x87=p\xf2\xdf\xa5\xd5\xa1t\x96\xe21\xd4\x16\xbc"] = loadfxasset("\x1f\x92*6L\x9c\xff\xff\xb0\xab\xd3O7\b\x10\xe6\xd8B\x887\xed\xda\xe9qrl\x18!?\xafC\x99\x99");
  level.g_effect["/\xbac\xa0\x99\xa9D\x9ehL\r\xb9}\x88\x13\xc7\x87\xca"] = loadfxasset("\xe8\x849\xf7$\x9d\xe4AF\x10Uu\xf2o\x01w?\xe0\xad\xb3]k\"\\\x9fh&\x04_`\r");
  level.g_effect["8l\v\xe5\xac\x9c\xf5\xf6f3\xccZ\xe4Y\xafl\xc2'\x9d\xb2"] = loadfxasset("\xc5)\xce\xa5\vw\x1b\xb8\xaa\xdfAB\x1dO|\xa8\x18\xb2\xeb\xbf\xaf\x06A\x85\xe3h\xc29G`\xf3-n");
  level.g_effect["z<\x82\xb1\xf1\xf9\xa7O\x95\x90n6d\xcfh\x1ek\v"] = loadfxasset("v\xcc\x1e_Zw\x1c\xd7br\xbev\xb0k\xb2\x1cc\x85^\xfa7\xd0K\xca\xd8\x8c\xbe\xc4re\xb0\xd6");
}

function initplayerprecache() {
  precachestring(&"game/get_to_cover");
  precachestring(&"game/get_to_cover_swim");
  directions = ["\x14#\x01\x89\f\x81", "=\xff0b", "o0\xee\xc1\x8c"];

  foreach(direction in directions) {
    precacheshader("5\x1dAm-\xdf\xf3\x9d\xc5E@\xe0\xd9\x8f\x88\xf7\x17" + direction);
    precacheshader("5\x1dAm-\xdf\xf3\x9d\xc5E@\xe0\xd9\x8f\x88\xf7\x17" + direction + "\xae\xd7D\xd8");
    precacheshader("5\x1dAm-\xdf\xf3\x9d\xc5E@\xe0\xd9\x8f\x88\xf7\x17" + direction + "2Sa\x1a\x1f#\x84");
    precacheshader("%B#\xae\xb9\xa8]\xfa\xd5W\xbd\x9a+\xd6r\x02" + direction);
    precacheshader("%B#\xae\xb9\xa8]\xfa\xd5W\xbd\x9a+\xd6r\x02" + direction + "2Sa\x1a\x1f#\x84");

    if(utility::playerarmorenabled()) {
      precacheshader("\xaa\x88\xc0\x13#\xe26a86T\xf1*\xac\xb1\x01%" + direction);
      precacheshader("\xaa\x88\xc0\x13#\xe26a86T\xf1*\xac\xb1\x01%" + direction + "2Sa\x1a\x1f#\x84");
    }
  }

  precacheshader("\x1e\x16\x1e\xf4\xcb\x03\xae?E\x19\x01\xf3\xd0H\xcf?\xafs\xe75[\t0m\x7fo\f\x01O");
  precacheshader("D\xb3\xbe\x9f\x9b\x13\x9eI\xf0\x1d\xa4\x19Cr\x1dG\xa4\xde\x83\x02Y\x97\xfd\xfd\xbc\xa2\xce");
  precacheshader("4g\xa2(e>\xca\x8e\x063TQ\xd1lg\x7f\xfe\xe3(XL\xc5\xb1\x1d\x9ex\xdb\x13\xb8");
  precacheshader("x\xbe14\xf5_\x12*+\xa4\xb41\x065\xfeg\xb5N\xbc@\xd28VB\xfd\x18^<");
  precacheshader("5\x87\xb2\xf7\xee\xf6\x8b\xd5[\xff\x80Ri\x17x\x80\xe6@\xb7_\x0fpx\xe0\x03\xc3\xd8\x9d\b\xc5\x9c\xcb\xfd\xde\xecP5\x7f\xfe");

  if(isarray(level.gamemodebundle.campaignsuits)) {
    foreach(suit in level.gamemodebundle.campaignsuits) {
      if(!isDefined(suit.suit)) {
        continue;
      }

      precachesuit(suit.suit);
    }
  }

  if(utility::playerarmorenabled()) {
    precacheshader("`^\x96\xc16/\fX\"\xac$u1\xafX\x8f\xbf\xf5f");
    precacheshader("\x1e\x16\x1e\xf4\xcb\x03\xae?E\x19\x01\xf3\xd0H\xcf?\xafs\xe75[\t0m\x7fo\f\x01O");
    precacheshader("\xab\xf8,\x14a\x91\xda|\xdc\xe60\xd5\xad\x03x}\xbag\xfdg\xba\x03\xa0(F_\x15\xfbo\x14\x8e\xf1\f");
  }
}

function initplayeromnvars() {
  self setclientomnvar("0\xc0\xc4\x8d\xb6\x169\x02\xd4\x92\xda\x8a \x95?\x99\x8e\t\xb3", 0);

  if(utility::playerarmorenabled()) {
    self setclientomnvar("\xf3\xc0\xf6\x9c|_\xbfU\x0f\x85N,\x80\xb4\xc6\xdb\xff\xc6", 0);
  }
}

function initplayernotifies() {
  self notifyonplayercommand("9Yl\xdb\x85\x91}\x1cr\x95n\xb9\x95\x91", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self notifyonplayercommand("9Yl\xdb\x85\x91}\x1cr\x95n\xb9\x95\x91", "\xa1\xae0\x8aJ4\xcf");
  self notifyonplayercommand("\xc8e\xa0\x86!6>\xf5\xc61\x84H", "n-\xa2\xff\xb9");
  self notifyonplayercommand("\xd4\xe0\xc3.\xa0\xf4\x8aYK@\xf6\xb4(", "\xa8\xb0\xbb#\xb9");
  self notifyonplayercommand("7kome\xf5\x0eNes\xdcY\x19", "?s\x87\xf6\xa0\xc0");
  self notifyonplayercommand("7\xad\xdbk\x95\xfa\xc9\xca\xc6Y\xc2\xb9Vd", "K\x9b5GR\xf2");
  self notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "\xa8\x94\xb5Ls\x10");
  self notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "\x18\xf77d\x8e\\\x1fjq\xbd(");
  self notifyonplayercommand("\x05HX\f\x05\xd4\xc50\xa6Dtt\v", "\xa8\x9c\xca\x8a\xf8\xfa\xc5\xc2:\xf2M\x1d\x98");
  self notifyonplayercommand("7\xc1\xe4\x96\xdc\x8e}\x0e\x9c\x95\x9b\xb9\xac#", "\xecp(\xbe\x95\xc9=");
  self notifyonplayercommand("7\xc1\xe4\x96\xdc\x8e}\x0e\x9c\x95\x9b\xb9\xac#", "\xa0>\xc2\x9f\x1a\x82\xb6\x96EF\xd2R");
  self notifyonplayercommand("7\xc1\xe4\x96\xdc\x8e}\x0e\x9c\x95\x9b\xb9\xac#", "\xc2&]\x85h<\x8f\x06\xd6j\xc5\xed\xdc");
  self notifyonplayercommand("\x86\xad\xfb\xd6\xcba@l*$\xd1\xfaO:", "\xaaQ\xf1{\xf3\x97\xba");
  self notifyonplayercommand("n\x02v\xec\x15.4\x92\x1f\xd3\x19\x17\xb9\xd0p", "~\xc42\xff\x1a*\xcc");
  self notifyonplayercommand("\x86\xad\xfb\xd6\xcba@l*$\xd1\xfaO:", "\xefAm\x17\x93\xa4\xb5\x91`\xb9\x80t\x10\x9a\x86\xad\xad\xe1\x8f\x94\xbbZ\x9a\x0fA");
  self notifyonplayercommand("n\x02v\xec\x15.4\x92\x1f\xd3\x19\x17\xb9\xd0p", "Za\xd1t\xc2l\xda_\xb0\xd6Zm\x13o\xbe\x16\xb1\xd8+7s\xd2\x13\x1be");
  self notifyonplayercommand("\f\xdc\x8e\xc0P\fr'\x15\xa1q", "\x18\xa9`\x13\x97\x9f\x1e\"?E[\xdb\xe4m\x9e;");
  self notifyonplayercommand("\f\xdc\x8e\xc0P\fr'\x15\xa1q", "\xcf\xa0Tt\xdc\x99\x95q\x96U2u");
  self notifyonplayercommand("\f\xdc\x8e\xc0P\fr'\x15\xa1q", "\xfa{\\\xcfik\xb7\x8d\xdb\xc8\x98\x99x\\\xb7\xb9\x8d\xbaZ>P\x9a");
  self notifyonplayercommand("%\xa3n>\xaf S\xa3\xf0\xdeq\xf0", "\xa4\x04\xf9\xc6\xcc\xe8ZO\x80i\xdfy\xd8\x82\x1b#");
  self notifyonplayercommand("%\xa3n>\xaf S\xa3\xf0\xdeq\xf0", "?y\xffRi\x89\xcb\xec\x97\xa7\xa3\xff");
  self notifyonplayercommand("%\xa3n>\xaf S\xa3\xf0\xdeq\xf0", "!\x8d\xb1r$\xf7.s\xc4\"nf\xc6\xd1\xa95\x1e\x88\x94\xde|\x7f");
  self notifyonplayercommand("3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#", "\xc3%\x906'N");
  self notifyonplayercommand(";\\?\xd6\x90:\xc93\xa4\xb1\xd0HW\x95", "z\xda\x86q\x96o");
  self notifyonplayercommand("9Yl\xdb\x85\x91}\x1cr\x95n\xb9\x95\x91", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self notifyonplayercommand("9Yl\xdb\x85\x91}\x1cr\x95n\xb9\x95\x91", "\xa1\xae0\x8aJ4\xcf");
  self notifyonplayercommand(":\x8dYuZ$\xf8\x8b^<(", "\x9cK\xa0pRY\xa6C$");
  self notifyonplayercommand(":\x8dYuZ$\xf8\x8b^<(", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self notifyonplayercommand("&\xa1\xd6%\xf2\xce\x81t\x84\xcb\x04\xe3j\x8d", "\xe88-\x97\xb82a");
  self notifyonplayercommand("&\xa1\xd6%\xf2\xce\x81t\x84\xcb\x04\xe3j\x8d", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p");
  self notifyonplayercommand("&\xa1\xd6%\xf2\xce\x81t\x84\xcb\x04\xe3j\x8d", "z\xf5\xbaH \x13\xbeo\x87");
  self notifyonplayercommand("{FD\xcb\x90\x17\xfe^]\xfe\xdf\x1b", "\x1d\x93\x85]\b\x86\xbb5");
  self notifyonplayercommand("{FD\xcb\x90\x17\xfe^]\xfe\xdf\x1b", "\xb5\xd0\xc2*A\xad\xfe\xcan");
  self notifyonplayercommand("{FD\xcb\x90\x17\xfe^]\xfe\xdf\x1b", "O\xc9\x9f>M\x11\xbf");
  self notifyonplayercommand("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "cc'\x93{\x1d.X\xdf");
  self notifyonplayercommand("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "\xfa\xfd\xaf\x10\x1f\xce=\x14\xca");
  self notifyonplayercommand("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "\x9c\x96\x81^\xcf\x96X|\xdd\xa0\x9fQ\xa1");
  self notifyonplayercommand("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "\xe4\xcd~5/S\x88l\xa6R\x19\xd9F");
  self notifyonplayercommand("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "{\xcf\xa0E\x01a\xfe\xaa\xda\x8e\xd0\xf5\"");
  self notifyonplayercommand("\x85\x8d\x1di\xden\x9b6\xed\xe8b", "T\x8c\xa2\xf1\xc1\xbf\x9d1\x89\xf4\xc9;\xec");
  self notifyonplayercommand("\xd2\x9f*\x15\xfa\x807\x17[\xee1", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8");
  self notifyonplayercommand("\xffg\x99G\xa01\t\xc0P\x8e\xbd", "\x13KI\xd7\x9b\xd1\xabpnj]+\xe1");
  self notifyonplayercommand("v\xff\x99<\xed\xbb\xd2\xb1<\x0e\x93", "F\x8c\xae\xa5bx*'\xed#y\x9cn");
}

function initplayerentflags() {
  utility::ent_flag_init("\xfb\x17rZ%\xbb\x0f^N\xfb\x81\x1ci2\xd9\xda\xa63");
  utility::ent_flag_init("UGz\xa4\xbb\xd1R@\x11.\xa4\xf3\"\xfa\x82r\x02<\xf7\x9c\xac\x1c\x91\xa32\x1eH\x0f\x1e");
}

function initplayerdamage() {
  self.damage = spawnStruct();
  dispersedamagepush(&dispersedamagedefault, &damagefunctions);
  self.damage.impactsfx = utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
  initdeathsdooroverlaypulse();
  initbloodoverlay();
  visionsetwhizby("+\xa8\x1d\xb65\x1f");
}

function dispersedamagepush(dispersedamagefunc, damagefunctionsfunc) {
  assert(isDefined(self.damage));
  newnode = spawnStruct();
  newnode.func = dispersedamagefunc;
  newnode.var_d18e110688f90518 = damagefunctionsfunc;

  if(isDefined(self.damage.disperse)) {
    self.damage.disperse.next = newnode;

    if(!isDefined(newnode.var_d18e110688f90518)) {
      newnode.var_d18e110688f90518 = self.damage.disperse.var_d18e110688f90518;
    }

    newnode.prev = self.damage.disperse;
  }

  self.damage.disperse = newnode;
  return newnode;
}

function dispersedamagepop(dispersedamagenode) {
  assert(isDefined(dispersedamagenode));
  assert(isDefined(dispersedamagenode.func));

  if(isDefined(dispersedamagenode.prev)) {
    dispersedamagenode.prev.next = dispersedamagenode.next;
  }

  if(isDefined(dispersedamagenode.next)) {
    dispersedamagenode.next.prev = dispersedamagenode.prev;
  }

  if(self.damage.disperse == dispersedamagenode) {
    self.damage.disperse = dispersedamagenode.prev;
  }

  dispersedamagenode.func = undefined;
  dispersedamagenode.next = undefined;
  dispersedamagenode.prev = undefined;
  dispersedamagenode.var_d18e110688f90518 = undefined;
  assert(isDefined(self.damage.disperse));
}

function dispersedamage(dispersedamagenode, damage, attacker, direction, point, type, objweapon, inflictor, dflags) {
  player = self;

  if(isDefined(dispersedamagenode.func)) {
    player[[dispersedamagenode.func]](dispersedamagenode, damage, attacker, direction, point, type, objweapon, inflictor, dflags);
  }
}

function initdamageoverlay() {
  self.damage.overlay = newclienthudelem(self);
  self.damage.overlay.sort = 12;
  self.damage.overlay.x = 0;
  self.damage.overlay.y = 0;
  self.damage.overlay.alignx = "=\xff0b";
  self.damage.overlay.aligny = "\x1d Q";
  self.damage.overlay.foreground = 0;
  self.damage.overlay.lowresbackground = 1;
  self.damage.overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.overlay.alpha = 0;
  self.damage.overlay.enablehudlighting = 1;
  self.damage.overlay setshader("\x1e\x16\x1e\xf4\xcb\x03\xae?E\x19\x01\xf3\xd0H\xcf?\xafs\xe75[\t0m\x7fo\f\x01O", 640, 480);
}

function initfiredamageoverlay() {
  self.damage.firedamageoverlay = newclienthudelem(self);
  self.damage.firedamageoverlay.sort = 9;
  self.damage.firedamageoverlay.x = 0;
  self.damage.firedamageoverlay.y = 0;
  self.damage.firedamageoverlay.alignx = "=\xff0b";
  self.damage.firedamageoverlay.aligny = "\x1d Q";
  self.damage.firedamageoverlay.foreground = 0;
  self.damage.firedamageoverlay.lowresbackground = 1;
  self.damage.firedamageoverlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.firedamageoverlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.firedamageoverlay.alpha = 0;
  self.damage.firedamageoverlay.enablehudlighting = 1;
  self.damage.firedamageoverlay setshader("D\xb3\xbe\x9f\x9b\x13\x9eI\xf0\x1d\xa4\x19Cr\x1dG\xa4\xde\x83\x02Y\x97\xfd\xfd\xbc\xa2\xce", 640, 480);
}

function initfirepainoverlay() {
  self.damage.firepainoverlay = newclienthudelem(self);
  self.damage.firepainoverlay.sort = 8;
  self.damage.firepainoverlay.x = 0;
  self.damage.firepainoverlay.y = 0;
  self.damage.firepainoverlay.alignx = "=\xff0b";
  self.damage.firepainoverlay.aligny = "\x1d Q";
  self.damage.firepainoverlay.foreground = 0;
  self.damage.firepainoverlay.lowresbackground = 1;
  self.damage.firepainoverlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.firepainoverlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.firepainoverlay.alpha = 0;
  self.damage.firepainoverlay.enablehudlighting = 1;
  self.damage.firepainoverlay setshader("4g\xa2(e>\xca\x8e\x063TQ\xd1lg\x7f\xfe\xe3(XL\xc5\xb1\x1d\x9ex\xdb\x13\xb8", 640, 480);
}

function initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 10;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "=\xff0b";
  self.damage.deathsdooroverlaypulse.aligny = "\x1d Q";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.deathsdooroverlaypulse.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
  self.damage.deathsdooroverlaypulse setshader("5\x87\xb2\xf7\xee\xf6\x8b\xd5[\xff\x80Ri\x17x\x80\xe6@\xb7_\x0fpx\xe0\x03\xc3\xd8\x9d\b\xc5\x9c\xcb\xfd\xde\xecP5\x7f\xfe", 640, 480);
}

function initbloodoverlay() {
  self.damage.bloodoverlay = newclienthudelem(self);
  self.damage.bloodoverlay.sort = 11;
  self.damage.bloodoverlay.x = 0;
  self.damage.bloodoverlay.y = 0;
  self.damage.bloodoverlay.alignx = "=\xff0b";
  self.damage.bloodoverlay.aligny = "\x1d Q";
  self.damage.bloodoverlay.foreground = 0;
  self.damage.bloodoverlay.lowresbackground = 1;
  self.damage.bloodoverlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.bloodoverlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.damage.bloodoverlay.alpha = 0;
  self.damage.bloodoverlay.enablehudlighting = 0;
  self.damage.bloodoverlay setshader("x\xbe14\xf5_\x12*+\xa4\xb41\x065\xfeg\xb5N\xbc@\xd28VB\xfd\x18^<", 640, 480);
}

function initplayerfocus() {
  self.focus = spawnStruct();
  self.focus.enemies = [];
  self.focus.additionalents = [];
  self.focus.buttonhelddown = 0;
  self.focus.usedonce = 0;
  self.focus.timeadjust = 0;
  self.focus.disabled = 0;
  self.focus.speed = 0;
  self.focus.minalpha = 0;
  self.focus.maxalpha = 0.6;
  self.focus.fadeintime = 0.5;
  self.focus.fadeouttime = 2.5;
  self.focus.minholdtime = 5;
  gamemodescriptbundle = getgamemodescriptbundle();

  if(isDefined(gamemodescriptbundle.objectivefocus) && gamemodescriptbundle.objectivefocus != % "") {
    focusproperties = getscriptbundle(gamemodescriptbundle.objectivefocus);

    if(isDefined(focusproperties)) {
      self.focus.speed = focusproperties.playerminspeed;
      self.focus.minalpha = focusproperties.minalpha;
      self.focus.maxalpha = focusproperties.maxalpha;
      self.focus.fadeintime = focusproperties.fadeintime;
      self.focus.fadeouttime = focusproperties.fadeouttime;
      self.focus.minholdtime = focusproperties.mintime;
    }
  }

  forcesetamount(0);
  set_focus_objectives_update_display(0);
  set_focus_infinite_hold(0);
  setomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 0);
  setsaveddvar(@ "objectivealphaenabled", 1);
  setsaveddvar(@ "objectivealpha", 0);
}

function initplayerfoley() {
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
}

function initplayerdefaultsettings() {
  self allowdoublejump(0);
  self allowwallrun(0);
  self enabledeathshield(1);
  player_movement_state();
  utility::registersharedfunc(#"player", #"getTakeCoverWarnings", &gettakecoverwarnings);
  utility::registersharedfunc(#"player", #"setTakeCoverWarnings", &settakecoverwarnings);
  utility::setcoverwarningcount();
  player_stats::init_stats();
  initarmor();
}

function watchweaponswap() {
  self endon("\x1e\xfd\xd1\xa2\a");
  weaponcallbackparams = spawnStruct();

  for(lastweapon = undefined; true; lastweapon = weapon) {
    weapon = self getcurrentweapon();
    weaponcallbackparams.lastweapon = lastweapon;
    weaponcallbackparams.weapon = weapon;
    callback::callback(#"player_weapon_change", weaponcallbackparams);
    self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
    updateviewkickscale();
  }
}

function function_81dc3283a7a53c94() {
  self waittill("\x94\x95\xf0\x1f1\xac\x85l<M\x82\xa1\xfc\xf9\xedP\t\xfd\xf0\xde\xf8\xca\x05\xbc4");
  usinglootcards = level.loot.lootpresent == "\xe5c\x0f\x18X,h\x1f\a";

  if(!usinglootcards) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\x1d\x95S\xfd\xf0\xa8", newweapon, oldweapon, newlootitem);

    if(isDefined(oldweapon)) {
      fullname = getsubstr(oldweapon.classname, 7);

      if(isDefined(self.weaponlootitems[fullname])) {
        oldweapon function_a40aafc5a10e20da(self.weaponlootitems[fullname]);
        self.weaponlootitems[fullname] = undefined;
      } else if(isDefined(level.var_3b92c361776fbe01[fullname])) {
        oldweapon function_a40aafc5a10e20da(level.var_3b92c361776fbe01[fullname]);
      }

      if(oldweapon.model == "\xec\xbfK|\au\xcd\xc2\x19<" || issubstr(oldweapon.classname, "7X\xf8\xf4;K\xa7")) {
        oldweapon delete();
      } else {
        viewdrop = level.player getstance() != "GX\xa9]\x82" && lengthsquared(getdvarvector(@ "hash_4f51f346f5292b74")) > 0.01;

        if(viewdrop) {
          oldweapon dontcastshadows();
          oldweapon utility::delaycallendon(0.5, "\x1e\xfd\xd1\xa2\a", &castshadows);
        }

        thread utility::callsharedfunc(#"loot", #"dropWeaponPost", oldweapon);
      }
    }

    if(isweapon(newweapon)) {
      fullname = getcompleteweaponname(newweapon);
      self.weaponlootitems[fullname] = newlootitem;
    }
  }
}

function function_bdab4da6ef4b173d(weaponclassarray) {
  assert(isPlayer(self));

  foreach(weapon in self getweaponslistprimaries()) {
    if(weapon == level.player.swimweapon) {
      continue;
    }

    if(weapon.inventorytype == "\xf0\n\x7fXb{\xcf") {
      continue;
    }

    classname = weaponclass(weapon);

    if(arraycontains(weaponclassarray, classname)) {
      return true;
    }
  }

  return false;
}

function function_7cbbeea0f366e160() {
  while(true) {
    self waittill("<dev string:x57>", amount);

    foreach(name, type in self.ammo) {
      if(utility_sp::playerlootenabled()) {
        loot::waittillnextloottime();
        loot::playlootsound(name);

        if(level.loot.types[name].createnotification) {
          thread loot::createnotification(name);
        }
      }

      setammonameamount(name, getammonamemaxamount(name));
    }
  }
}

function function_5a7a4ad70cd8f8bd(weaponclassarray) {
  num = 0;

  foreach(weapon in self getweaponslistprimaries()) {
    if(weapon == level.player.swimweapon) {
      continue;
    }

    classname = weaponclass(weapon);

    if(arraycontains(weaponclassarray, classname)) {
      num += self getweaponammostock(weapon);
    }
  }

  return num;
}

function getammonameamount(ammoname) {
  amount = 0;

  foreach(weapon in self getweaponslistprimaries()) {
    currname = getammoname(weapon);

    if(currname == ammoname) {
      amount = self getweaponammostock(weapon);
      break;
    }
  }

  return amount;
}

function getammonamemaxamount(ammoname) {
  amount = 0;

  foreach(weapon in self getweaponslistprimaries()) {
    currname = getammoname(weapon);

    if(currname == ammoname) {
      if(weapon.maxammo > amount) {
        amount = weapon.maxammo;
      }
    }
  }

  return amount;
}

function setammonameamount(ammoname, amount) {
  foreach(weapon in self getweaponslistprimaries()) {
    if(getammoname(weapon) == ammoname) {
      self setweaponammostock(weapon, amount);
    }
  }
}

function getammoname(weapon) {
  if(!isDefined(weapon)) {
    return undefined;
  }

  if(isnullweapon(weapon)) {
    return undefined;
  }

  ammoname = getweaponammopoolname(weapon);
  ammoname = attachmentammonamehack(ammoname);
  ammoname = localizeammonamehack(ammoname);
  return ammoname;
}

function localizeammonamehack(ammoname) {
  if(ammoname == % ".45 acp") {
    return % ".45 acp";
  } else if(ammoname == % "12 gauge") {
    return % "12 gauge";
  } else if(ammoname == % "hash_4c8c696e2e09f3d") {
    return % "12 gauge";
  } else if(ammoname == % "rocket") {
    return % "rocket";
  } else if(ammoname == % "hash_1c4243c41b2e739b") {
    return % "hash_1c4243c41b2e739b";
  } else if(ammoname == % "hash_71e5eeb8b03626c2") {
    return % "hash_71e5eeb8b03626c2";
  }

  return ammoname;
}

function attachmentammonamehack(ammoname) {
  if(ammoname == % "ub_mike203" || ammoname == % "ub_flare" || ammoname == % "ub_golf25") {
    return % "hash_71e5eeb8b03626c2";
  }

  return ammoname;
}

function function_212dadfe65a3af0c() {
  setDvar(@ "hash_458d682e4c270c67", "<dev string:x64>");
  loadoutfunctions = [];
  loadoutfunctions["<dev string:x68>"] = &weaponswap;
  loadoutfunctions["<dev string:x72>"] = &setarmor;
  loadoutfunctions["<dev string:x7b>"] = &setarmorplate;
  loadoutfunctions["<dev string:x89>"] = &offhandswap;
  loadoutfunctions["<dev string:x94>"] = &offhandremover;

  while(true) {
    newrequest = getDvar(@ "hash_458d682e4c270c67");

    if(newrequest != "<dev string:x64>") {
      updateplayerloadout(loadoutfunctions, newrequest);
      setDvar(@ "hash_458d682e4c270c67", "<dev string:x64>");
    }

    waitframe();
  }
}

function function_18997e7465f45cc6() {
  setdvarifuninitialized(@ "debug_deathsdoor", 0);
  self.debughealthhud = spawnStruct();
  self.debughealthhud.var_a4a689a98eba17de = [];
  self.debughealthhud.active = 0;
  self.debughealthhud.overkill = 0;

  while(!isDefined(self.damage.firedamage) && !isDefined(level.audio)) {
    waitframe();
  }

  while(true) {
    if(getdvarint(@ "player_debughealth") && !self.debughealthhud.active) {
      thread function_a89fcaaccb04d9d5();
      self.debughealthhud.active = 1;
    }

    if(!getdvarint(@ "player_debughealth") && self.debughealthhud.active) {
      self notify("<dev string:xa5>");

      foreach(hudelm in self.debughealthhud.var_a4a689a98eba17de) {
        self.debughealthhud.var_a4a689a98eba17de = arrayremove(self.debughealthhud.var_a4a689a98eba17de, hudelm);
        hudelm destroy();
      }

      self.debughealthhud.active = 0;
    }

    if(getdvarint(@ "debug_deathsdoor") && !istrue(self.debug_deathsdoor)) {
      self.debug_deathsdoor = 1;
      utility_sp::do_damage(1, self.origin);
    }

    if(!getdvarint(@ "debug_deathsdoor") && istrue(self.debug_deathsdoor)) {
      self.debug_deathsdoor = 0;
    }

    waitframe();
  }
}

function function_a89fcaaccb04d9d5() {
  self endon("<dev string:xa5>");
  x_start = -90;
  y = 400;
  fontscale = 1;
  function_4c85f92aa491a443("<dev string:xc0>", "<dev string:xce>");
  function_4c85f92aa491a443("<dev string:xe0>", "<dev string:xea>");
  function_4c85f92aa491a443("<dev string:xf7>", "<dev string:x105>");
  function_4c85f92aa491a443("<dev string:x117>", "<dev string:x125>");
  colorfiredamagemin = (1, 1, 1);
  var_935ad5d28b7b597c = (1, 1, 0);
  var_de0094fe55af7118 = (1, 0, 0);
  var_5e7db402bfad99e7 = (1, 0, 0);
  var_b746b4f89c23613d = (0, 1, 0);

  while(true) {
    waittillframeend();
    normfire = math::normalize_value(0, 100, self.damage.firedamage);

    if(normfire > 0.5) {
      color = math::factor_value(var_935ad5d28b7b597c, var_de0094fe55af7118, (normfire - 0.5) * 2);
    } else {
      color = math::factor_value(colorfiredamagemin, var_935ad5d28b7b597c, normfire * 2);
    }

    self.debughealthhud.var_a4a689a98eba17de["<dev string:xc0>"] setvalue(self.damage.firedamage);
    self.debughealthhud.var_a4a689a98eba17de["<dev string:xc0>"].color = color;

    if(utility::damageflag(2)) {
      color = (1, 0, 0);
    } else {
      color = (0, 1, 0);
    }

    self.debughealthhud.var_a4a689a98eba17de["<dev string:xe0>"] setvalue(self.health);
    self.debughealthhud.var_a4a689a98eba17de["<dev string:xe0>"].color = color;
    normfire = math::normalize_value(0, 100, self.damage.firehealth);
    color = math::factor_value(var_5e7db402bfad99e7, var_b746b4f89c23613d, normfire);
    self.debughealthhud.var_a4a689a98eba17de["<dev string:xf7>"] setvalue(self.damage.firehealth);
    self.debughealthhud.var_a4a689a98eba17de["<dev string:xf7>"].color = color;

    if(isalive(self)) {
      if(utility::damageflag(2)) {
        if(utility::damageflag(1)) {
          deathshieldtime = getdeathsshieldduration();
          self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"] settext("<dev string:x136>" + deathshieldtime + "<dev string:x14b>");
          self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"].color = (0, 1, 0);
        } else {
          deathsdoortime = getdeathsdoorduration();
          self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"] settext("<dev string:x157>" + deathsdoortime + "<dev string:x14b>");
          self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"].color = (1, 0, 0);
        }
      } else {
        self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"] settext("<dev string:x169>");
        self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"].color = (0.75, 0.75, 0.75);
      }
    } else {
      self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"] settext("<dev string:x170>");
      self.debughealthhud.var_a4a689a98eba17de["<dev string:x117>"].color = (0.5, 0.5, 0.5);
    }

    waitframe();
  }
}

function function_f9d154724c904dec(reason, amount) {
  if(!getdvarint(@ "player_debughealth")) {
    return;
  }

  if(!isDefined(reason)) {
    reason = "<dev string:x178>";
  }

  if(!isDefined(amount)) {
    amount = "<dev string:x1ab>";
  } else {
    amount = "<dev string:x1b0>" + amount;
  }

  function_4c85f92aa491a443("<dev string:x1bf>", "<dev string:x1c8>");
  self.debughealthhud.var_a4a689a98eba17de["<dev string:x1bf>"] settext("<dev string:x1d3>" + reason + amount);
  self.debughealthhud.var_a4a689a98eba17de["<dev string:x1bf>"].color = (1, 0, 0);
}

function function_4c85f92aa491a443(id, label) {
  ybase = 75;
  rowspacing = 15;
  yoffset = self.debughealthhud.var_a4a689a98eba17de.size * rowspacing;
  hudelm = newclienthudelem(self);
  hudelm.sort = 10;
  hudelm.x = 10;
  hudelm.y = ybase + yoffset;
  hudelm.fontscale = 1;
  hudelm.alignx = "<dev string:x1e1>";
  hudelm.aligny = "<dev string:x1e9>";
  hudelm.horzalign = "<dev string:x1f0>";
  hudelm.vertalign = "<dev string:x1f0>";
  hudelm.sort = 1;
  hudelm.label = label;
  self.debughealthhud.var_a4a689a98eba17de[id] = hudelm;
}

function updateplayerloadout(loadoutfunctions, newrequest) {
  tokens = strtok(newrequest, "<dev string:x1fe>");
  type = tokens[0];
  request = tokens[1];

  if(isDefined(loadoutfunctions[type])) {
    [[loadoutfunctions[type]]](request);
    return;
  }

  assertmsg(type + "<dev string:x203>");
}

function weaponswap(weapon) {
  currentweapon = self getcurrentprimaryweapon();

  if(isDefined(currentweapon)) {
    utility_sp::take_weapon(currentweapon);
  }

  self giveweapon(weapon);
  self switchtoweaponimmediate(weapon);
}

function setarmor(amount) {
  setarmoramount(int(amount));
  self.hadarmor = 1;
}

function setarmorplate(amount) {
  setarmorplateamount(self.armor.plates + int(amount));
}

function offhandremover(slot) {
  offhand = self getcurrentoffhand(slot);
  utility_sp::take_offhand(offhand);
}

function goprohelmetprecache(helmetmodel, overlay, vision) {
  if(isDefined(helmetmodel)) {
    precachemodel(helmetmodel);
    level.player.goprohelmet = helmetmodel;
  }

  if(isDefined(overlay)) {
    precacheshader(overlay);
    level.player.goprooverlay = newclienthudelem(level.player);
    level.player.goprooverlay.sort = 0;
    level.player.goprooverlay.foreground = 0;
    level.player.goprooverlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    level.player.goprooverlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    level.player.goprooverlay.alpha = 0;
    level.player.goprooverlay.enablehudlighting = 1;
    level.player.goprooverlay setshader(overlay, 640, 480);
  }

  level.player.goprovision = vision;
}

function goprotest() {
  level.player thread goproplayerthread();
}

function goproplayerthread() {
  self endon("\x1e\xfd\xd1\xa2\a");
  togglebutton = "\xd8\xd3\xc2\xc5\xf6\xb8\x03\x92U\xee";

  while(true) {
    buttondebounce(togglebutton);
    thread goprohelmet();
    buttondebounce(togglebutton);
    thread gopronone();
  }
}

function goprohelmet() {
  self notify("\x1d\xd4\xf8\xae\x9c\x8c\x95{\xf8");
  helmet = undefined;
  goprocamerasettings(1);
  global_offset = (0, 0, 0);
  offset_gun = (-3, -1, 5) + global_offset;
  offset_helmet = (10, 5, -10) + global_offset;

  if(isDefined(self.goprohelmet)) {
    helmet = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
    helmet setModel(self.goprohelmet);
    helmet linktoplayerview(self, "\xec\xbfK|\au\xcd\xc2\x19<", offset_helmet, (-90, 90, 0), 1, "\xbc\xc4\xc6O\xec\xca\xd00L\x7f\xe9");
  }

  self waittill("\x1d\xd4\xf8\xae\x9c\x8c\x95{\xf8");

  if(isDefined(helmet)) {
    helmet delete();
  }
}

function gopronone() {
  goprocamerasettings(0);
  self notify("\x1d\xd4\xf8\xae\x9c\x8c\x95{\xf8");
}

function goprocamerasettings(state) {
  if(state) {
    level.player modifybasefov(85, 0.05);
    setsaveddvar(@ "cg_fov", 85);

    if(isDefined(self.goprovision)) {
      visionsetfadetoblack(self.goprovision, 0);
    }

    if(isDefined(self.goprooverlay)) {
      self.goprooverlay.alpha = 1;
    }

    givegoproattachments();
    setsaveddvar(@ "r_mbradialoverridedistortion", 0.1585);
    setsaveddvar(@ "r_mbradialoverrideradius", -0.478);
    setsaveddvar(@ "r_mbradialoverridestrength", 0.014);
    setsaveddvar(@ "r_mbradialoverridechromaticaberration", 1);
    setsaveddvar(@ "hash_c533867ac3fdc690", 6);
    setsaveddvar(@ "handheldcamerarotationscale", 8);
    setsaveddvar(@ "hash_d026a87a69c3281c", 2);
    setsaveddvar(@ "hash_d50a0278d87ca09d", 2.1);
    setsaveddvar(@ "r_mbvelocityscale", 2);
    setomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 1);
    setsaveddvar(@ "cg_drawcrosshair", 0);
    return;
  }

  level.player modifybasefov(65, 0.05);
  setsaveddvar(@ "cg_fov", 65);

  if(isDefined(self.goprovision)) {
    visionsetfadetoblack("", 0);
  }

  if(isDefined(self.goprooverlay)) {
    self.goprooverlay.alpha = 0;
  }

  takegoproattachments();
  setsaveddvar(@ "r_mbradialoverridedistortion", 0);
  setsaveddvar(@ "r_mbradialoverrideradius", 0);
  setsaveddvar(@ "r_mbradialoverridestrength", 0);
  setsaveddvar(@ "r_mbradialoverridechromaticaberration", 0);
  setsaveddvar(@ "handheldcamerarotationscale", 1);
  setsaveddvar(@ "hash_c533867ac3fdc690", 1);
  setsaveddvar(@ "hash_d026a87a69c3281c", 1);
  setsaveddvar(@ "hash_d50a0278d87ca09d", 1);
  setsaveddvar(@ "r_mbvelocityscale", 1);
  setomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 0);
  setsaveddvar(@ "cg_drawcrosshair", 1);
}

function givegoproattachments() {
  if(isDefined(self.goprohasattachments)) {
    return;
  }

  currentweapon = self.currentweapon;
  weapons = self.primaryinventory;

  foreach(weapon in weapons) {
    attachments = weapon.attachments;
    attachments = utility::array_add(attachments, "fJ>\f\xfe\x99eW\xf3\xb7g\x86");
    attachments = utility::alphabetize(attachments);
    newweapon = utility_sp::make_weapon(getweaponbasename(weapon), attachments);
    self takeweapon(weapon);
    self giveweapon(newweapon);
  }

  switchtoweaponwithbasename(currentweapon);
  self.goprohasattachments = 1;
}

function takegoproattachments() {
  if(!isDefined(self.goprohasattachments)) {
    return;
  }

  currentweapon = self.currentweapon;
  weapons = self.primaryinventory;

  foreach(weapon in weapons) {
    attachments = weapon.attachments;
    attachments = arrayremove(attachments, "fJ>\f\xfe\x99eW\xf3\xb7g\x86");
    attachments = utility::alphabetize(attachments);
    newweapon = utility_sp::make_weapon(getweaponbasename(weapon), attachments);
    self takeweapon(weapon);
    self giveweapon(newweapon);
  }

  switchtoweaponwithbasename(currentweapon);
  self.goprohasattachments = undefined;
}

function switchtoweaponwithbasename(weapontocheck) {
  weapons = self.primaryinventory;

  foreach(weapon in weapons) {
    if(getweaponbasename(weapon) == getweaponbasename(weapontocheck)) {
      self switchtoweaponimmediate(weapon);
      break;
    }
  }
}

function buttondebounce(button) {
  while(!level.player buttonPressed(button)) {
    wait 0.05;
  }

  while(level.player buttonPressed(button)) {
    wait 0.05;
  }
}

function ladderpistol() {
  setsaveddvar(@ "ladderenableweapon", 1);
  setsaveddvar(@ "hash_cb9877bb7c7c0aa7", 1);
}

function managereloadammo(currentgun) {
  clipcount = self getweaponammoclip(currentgun);
  maxclip = weaponclipsize(currentgun);
  ammostock = self getammocount(currentgun) - clipcount;
  var_d679a6734afd9018 = maxclip - clipcount;
  ammostock -= var_d679a6734afd9018;
  self setweaponammostock(currentgun, ammostock);
  self setweaponammoclip(currentgun, maxclip);
}

function playeraltweapon() {
  enableplayeraltweapon();
  val::register("\xee\xacX\x83\xdbs\xbea\xb1G\xebk{#\xb2", 1, 1, "\x127\xca\x8d3", &enableplayeraltweapon, "~\xa9\xccdcE");
}

function enableplayeraltweapon(enabled) {
  if(!isDefined(enabled)) {
    enabled = 1;
  }

  if(enabled) {
    self setactionslot(3, "\xf0\n\x7f\xd8b{\xcf");
    return;
  }

  self setactionslot(3, "");
}

function playerdamagemain() {
  updatedamageindicatortype();

  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }
}

function armorbroke() {
  return self.hadarmor && !hasarmor() ? 1 : 0;
}

function maintainhealthfloor() {
  if(self.health > 0 && self.health < 2) {
    set_normalhealth(2 / self.maxhealth);
  }
}

function ondeathfinalhit(attacker, type, damage) {
  if(!shoulddopainvision()) {
    return;
  }

  if(type != "\b\x89z\xc1\xf1\xd4I\xf3") {
    thread damagebloodoverlaydirectional(attacker.origin, type, 60);
  }

  thread deathsdooroverlaypulsefinal();

  function_f9d154724c904dec(type, damage);
}

function damagefunctions(type) {
  switch (type) {
    case #"hash_d8646db4e6ee3658":
      return [ &damagefire, &regeneratehealth, &deathshieldinvulnerability];
    default:
      return [ &defaultdamagenotify, &shouldkillimmediatly, &damageinvulnerability, &deathshieldinvulnerability, &regeneratehealth, &damageeffects, &utility::takecoverwarning];
  }
}

function defaultdamagenotify(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  self notify("\xae\x15\xd7V\x9c\xca\xc3\xd4&)\xf7\xf7\x11");
}

function dispersedamagedefault(node, damage, attacker, direction, point, type, objweapon, inflictor, dflags) {
  var_c796ef0ac6089441 = isDefined(attacker) && istrue(attacker.var_823b50458823b6a8);

  if(!var_c796ef0ac6089441) {
    damage = handleexplosivedamage(damage, type, objweapon);
  }

  var_65b35d20d9befcbe = isDefined(attacker) && istrue(attacker.var_480eb3b92220b394);

  if(!var_65b35d20d9befcbe) {
    damage = utility::handlemeleedamage(objweapon, type, damage);
  }

  switch (type) {
    case #"hash_5f1054c48d66fd1c":
    case #"hash_776a1ebadca6298c":
    case #"hash_966768b3f0c94767":
    case #"hash_a86d8c43482948a4":
      self.var_5732b2d6948b3e42 = gettime();
      break;
    default:
      break;
  }

  var_702da93c1ad15042 = 0;
  var_de4ce2b33de4bcd9 = 0;

  if(type == "\b\x89z\xc1\xf1\xd4I\xf3") {
    firedamagemin = 3.5;
    var_702da93c1ad15042 = damage;
    firedamage = damage * 1 / self.damagemultiplier;

    if(firedamage < firedamagemin) {
      firedamage = firedamagemin;
    }

    self.damage.firedamage += firedamage * getfireengulfrate();
    self.damage.firedamage = min(self.damage.firedamage, 100);
  } else if(hasarmor()) {
    lastarmor = min(getarmoramount(), getarmormaxamount());
    inversearmorratio = 1 - getarmoramount() / getarmormaxamount();
    armordamagetohealthratio = math::factor_value(self.gs.armordamagetohealthratiomin, self.gs.armordamagetohealthratiomax, inversearmorratio);

    if(armorprotectsdamagetype(type, objweapon)) {
      var_de4ce2b33de4bcd9 = min(damage, lastarmor);
      overflow = damage - lastarmor;
    } else {
      var_de4ce2b33de4bcd9 = 0;
      overflow = damage;
    }

    if(overflow > 0) {
      overflow *= self.gs.damagemultiplierhealth;

      if(self function_f6390b4f5eaf09d9(type, dflags, attacker)) {
        overflow /= self.gs.damagemultiplierarmor;
      }
    } else {
      overflow = 0;
    }

    var_702da93c1ad15042 = var_de4ce2b33de4bcd9 * armordamagetohealthratio + overflow;
    finalarmor = clamp(lastarmor - var_de4ce2b33de4bcd9, 0, getarmormaxamount());
    setarmoramount(finalarmor);
  } else if(shouldflashinvul(type)) {
    var_702da93c1ad15042 = 0;
  } else {
    var_702da93c1ad15042 = damage;
  }

  overkilldamage = max(var_702da93c1ad15042 - self.lasthealth, 0);

  if(isDefined(level.battlechatter) && utility::isbulletdamage(type) && isDefined(attacker) && isai(attacker) && isalive(attacker)) {
    function_99e8e66d1969d7cb(attacker, undefined, "9\xa2K\xdb\xa6B5\xbe\xdb\x95(1\xf3)", "\x9fQ\xc8\xe7\xbf\x1a,WP\x11\x94)2\x84");
  }

  if(!istrue(self.var_b4b6772907565113) && isspreadweapon(objweapon) && self.lasthealth > self.maxhealth * 0.8) {
    overkilldamage = 0;
  }

  finalhealth = clamp(self.lasthealth - var_702da93c1ad15042, 1, self.maxhealth);
  set_normalhealth(finalhealth / self.maxhealth);
  calldamagefunctions(node.var_d18e110688f90518, damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage);
  self.damage.healthdamage = int(var_702da93c1ad15042);
  self.damage.lightarmordamage = int(var_de4ce2b33de4bcd9);
  return overkilldamage;
}

function handleexplosivedamage(damage, type, objweapon) {
  if(!isexplosivedamage(type)) {
    return damage;
  }

  if(isDefined(objweapon.basename) && objweapon.basename == "\xef\xd8\x94\x8d\xba") {
    return 0;
  }

  return damage * self.gs.damagemultiplierexplosive * self.gs.basehealthexplosivedamagemultiplier;
}

function shouldflashinvul(type) {
  flashinvultypes = ["\xac6\xc1;\x9c|\xd5]5\x80\xcb~\xb5\xe7\xb4\xa1", "\xd5_\xc1\xe1U\xf4\x06m\x0e\t\xc6e\xf4\x91\xdc\xd4\xf7"];

  if(isDefined(self.flashinvul) && arraycontains(flashinvultypes, type)) {
    return true;
  }

  return false;
}

function damagefire(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  self notify("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");
  self endon("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");

  if(!utility::damageflag(32)) {
    thread setplayeronfire(attacker, inflictor);
  }

  if(!utility::damageflag(16)) {
    thread setplayerinfire();
  }

  wait 0.1;

  if(utility::damageflag(16)) {
    thread setplayeroutoffire();
  }

  lerpoutfireintensity();

  if(utility::damageflag(32)) {
    thread setplayerofffire();
  }
}

function firehealth(attacker, inflictor) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("d\x16[\x16\x9d+\xf5\xcc\x96\x93\xb2\xeb\xf6f3");
  wait 0.05;
  timer = 0;
  firehealthfloat = self.damage.firehealth;

  while(true) {
    deathtime = getfireinvulseconds();

    if(self.damage.firedamage >= 100) {
      timer += 0.05;
    } else {
      timer -= 0.05;
    }

    timer = clamp(timer, 0, deathtime);
    firehealthfloat = (1 - timer / deathtime) * 100;
    firehealthfloat = clamp(firehealthfloat, 0, 100);
    self.damage.firehealth = math::round_float(firehealthfloat, 0);

    if(self.damage.firehealth == 0) {
      killplayer(attacker, "\b\x89z\xc1\xf1\xd4I\xf3", inflictor, "\xcciN\xca");
    }

    waitframe();
  }
}

function setplayeronfire(attacker, inflictor) {
  utility::setdamageflag(32, 1);
  thread firehealth(attacker, inflictor);
  thread firedamagefx();
}

function setplayerofffire() {
  self notify("d\x16[\x16\x9d+\xf5\xcc\x96\x93\xb2\xeb\xf6f3");
  utility::setdamageflag(32, 0);
  firedamagefxoff();
}

function setplayerinfire() {
  utility::setdamageflag(16, 1);
  thread firedamagegesture();
}

function setplayeroutoffire() {
  utility::setdamageflag(16, 0);
  firedamagegesturesoff();
}

function firedamagegesture() {
  if(!shouldplayfiregesture()) {
    return;
  }

  level.player forceplaygestureviewmodel("?\xcc\f%\xe1&H\xe0\x92\xd6@\x0fw0\xd9\x04\x97", undefined, 0.75);
  level.player val::set("\x9eb\xb9N\xbc;", "\xe4\xf1G", 0);
  level.player val::set("\x9eb\xb9N\xbc;", "\xc9\xca\x1boX\x8c", 0);
  level.player val::set("\x9eb\xb9N\xbc;", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12", 0);
  level.player.firegesture = 1;
}

function firedamagegesturesoff() {
  if(!isDefined(level.player.firegesture)) {
    return;
  }

  level.player stopgestureviewmodel("?\xcc\f%\xe1&H\xe0\x92\xd6@\x0fw0\xd9\x04\x97", 0.5, 0);
  level.player val::reset_all("\x9eb\xb9N\xbc;");
  level.player.firegesture = undefined;
}

function shouldplayfiregesture() {
  if(isnullweapon(level.player getcurrentprimaryweapon())) {
    return false;
  }

  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(!level.player isweaponsenabled()) {
    return false;
  }

  if(level.player isonladder()) {
    return false;
  }

  if(level.player playerads() > 0.1) {
    return false;
  }

  if(!level.player val::get("\xe5\x06\xb0\bE\x16")) {
    return false;
  }

  return true;
}

function initfirevfxent() {
  self.damage.firevfx = utility::spawn_tag_origin();
  self.damage.firevfx function_7ec33711a0892c((50, 0, 0));
  thread firedamagevfxintensitythink(self.damage.firevfx);
}

function initfirefxrumbleent() {
  self.damage.firerumble = utility_sp::get_rumble_ent();
}

function initfiresfxfire() {
  self.damage.firesfx = utility::spawn_script_origin();
  self.damage.firesfx function_7ec33711a0892c();
  self.damage.firesfx playLoopSound("\x82\x9f\xbe-\x8fIm\x9a\xad\xbcV");
  self.damage.firesfx scalevolume(0, 0);
  self.damage.firesfx scalepitch(0, 0);
}

function initfiresfxdrone() {
  self.damage.firedronesfx = utility::spawn_script_origin();
  self.damage.firedronesfx function_7ec33711a0892c();
  self.damage.firedronesfx playLoopSound("\xda\xd5\xf3\x85\xccW\xac\xb5\xd5\xa0w,\x15s\x1a\x9a\xc6");
  self.damage.firedronesfx scalevolume(0, 0);
  self.damage.firedronesfx scalepitch(0, 0);
}

function initfiresfxsmolder() {
  self.damage.firesmolsfx = utility::spawn_script_origin();
  self.damage.firesmolsfx function_7ec33711a0892c();
  self.damage.firesmolsfx playLoopSound("_k\n\xd1\xc4\xae\xc8\xa5\x04|\x14\xd8\xefL{\xcad\xe4v");
  self.damage.firesmolsfx scalevolume(0, 0);
  self.damage.firesmolsfx scalepitch(0, 0);
}

function function_7ec33711a0892c(var_308c318db5bd0a5e, var_41ab0a2ca97bfa40) {
  if(level.player.model == "") {
    parent_ent = level.player getlinkedparent();

    if(isDefined(parent_ent)) {
      if(parent_ent tagexists("\xec\xbfK|\au\xcd\xc2\x19<")) {
        self linkTo(parent_ent, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
      }
    } else {
      println("<dev string:x26c>");
    }

    return;
  }

  origin_offset = var_308c318db5bd0a5e ?? (0, 0, 0);
  angles_offset = var_41ab0a2ca97bfa40 ?? (0, 0, 0);
  self linkTo(level.player, "\xec\xbfK|\au\xcd\xc2\x19<", origin_offset, angles_offset);
}

function firedamagefx() {
  self endon("d\x16[\x16\x9d+\xf5\xcc\x96\x93\xb2\xeb\xf6f3");

  if(!isDefined(self.damage.firevfx)) {
    initfirevfxent();
  }

  if(!isDefined(self.damage.firerumble)) {
    initfirefxrumbleent();
  }

  if(!isDefined(self.damage.firesfx)) {
    initfiresfxfire();
  }

  if(!isDefined(self.damage.firedronesfx)) {
    initfiresfxdrone();
  }

  if(!isDefined(self.damage.firesmolsfx)) {
    initfiresfxsmolder();
  }

  if(!isDefined(self.damage.firedamageoverlay)) {
    initfiredamageoverlay();
  }

  if(!isDefined(self.damage.firepainoverlay)) {
    initfirepainoverlay();
  }

  var_85d6dae37b529dc1 = 0;
  var_eef269b7567a7333 = 0.1;
  var_ab3a028fc2e4fb74 = 0;

  while(true) {
    waittillframeend();
    normfire = firedamageratio();
    self.damage.firepainoverlay.alpha = math::factor_value(0.45, 1, normfire);

    if(utility::damageflag(16)) {
      var_85d6dae37b529dc1 = normfire;

      if(!var_ab3a028fc2e4fb74) {
        playFXOnTag(level.g_effect["i\x8bo\xa6\xae\xf7\xce~\xce\x98g`\xcbb\x12)\xd2\xf4\xa6\xc1"], self.damage.firevfx, "\xec\xbfK|\au\xcd\xc2\x19<");
        thread utility::play_sound_in_space("A\x10\n5\xd9\xccNd\x1c\x9e\xaf\xe3\x0e\xcf\xab\xc4\x17", level.player.origin);
        earthquake(0.2, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
        var_ab3a028fc2e4fb74 = 1;
      }
    } else {
      var_85d6dae37b529dc1 -= var_eef269b7567a7333;
      var_85d6dae37b529dc1 = max(0, var_85d6dae37b529dc1);

      if(var_ab3a028fc2e4fb74) {
        playFXOnTag(level.g_effect["\x93LO\x82\x1fe\xc1 \x1c\xa8~;#\xef}\x92nf\xf6\x80\xf3m\xa8Q "], self.damage.firevfx, "\xec\xbfK|\au\xcd\xc2\x19<");
        thread utility::play_sound_in_space("R\xc0\xe9\x8c8\x96,\x06\xf4\xb2\xc9\x04n9\xfe\x19", level.player.origin);
        earthquake(0.1, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
        var_ab3a028fc2e4fb74 = 0;
      }
    }

    self.damage.firedamageoverlay.alpha = math::factor_value(0.45, 1, var_85d6dae37b529dc1);
    self.damage.firerumble.intensity = math::factor_value(0, 0.8, var_85d6dae37b529dc1);
    quakemag = math::factor_value(0.02, 0.15, var_85d6dae37b529dc1);
    earthquake(quakemag, 0.2, level.player.origin, 2000);
    radialdistortion = math::factor_value(0, -0.01, var_85d6dae37b529dc1);
    radialstrength = math::factor_value(0, 0.02, var_85d6dae37b529dc1);
    setsaveddvar(@ "r_mbradialoverridedistortion", radialdistortion);
    setsaveddvar(@ "r_mbradialoverridestrength", radialstrength);
    var_5228ec5e15a302c = math::factor_value(0, 1.1, var_85d6dae37b529dc1 * var_85d6dae37b529dc1);
    var_bd264994976ac6ff = math::factor_value(1.7, 2, var_85d6dae37b529dc1);
    self.damage.firedronesfx scalevolume(var_5228ec5e15a302c, 0.05);
    self.damage.firedronesfx scalepitch(var_bd264994976ac6ff, 0.05);
    firesfxvol = math::factor_value(0, 1.7, var_85d6dae37b529dc1);
    firesfxpitch = math::factor_value(0.8, 1.2, var_85d6dae37b529dc1);
    self.damage.firesfx scalevolume(firesfxvol, 0.05);
    self.damage.firesfx scalepitch(firesfxpitch, 0.05);
    var_7ac41a261997ae44 = math::factor_value(0.2, 1.1, normfire);
    var_f376321de3e49f57 = math::factor_value(0.7, 1.3, normfire);
    self.damage.firesmolsfx scalevolume(var_7ac41a261997ae44, 0.05);
    self.damage.firesmolsfx scalepitch(var_f376321de3e49f57, 0.05);
    waitframe();
  }
}

function firedamagevfxintensitythink(fxent) {
  fxent endon("\x1e\xfd\xd1\xa2\a");
  currentfx = "";

  while(true) {
    waittillframeend();

    if(utility::damageflag(16)) {
      firevfxnames = getonfirevfxnames();
    } else {
      firevfxnames = getofffirevfxnames();
    }

    var_d0edcd6732ebb12b = firevfxnames.size;
    firefxindex = math::round_float(firedamageratio() * var_d0edcd6732ebb12b, 0, 1);
    firefxindex = min(firefxindex, var_d0edcd6732ebb12b - 1);
    firefxindex = int(firefxindex);
    desiredfx = firevfxnames[firefxindex];

    if(currentfx != desiredfx) {
      if(currentfx != "") {
        stopFXOnTag(level.g_effect[currentfx], fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
      }

      playFXOnTag(level.g_effect[desiredfx], fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
      currentfx = desiredfx;
    }

    waitframe();
  }
}

function getonfirevfxnames() {
  return ["u\xf6'0\x8er\x1f>Q-)\xde6\xbe\x96\xc2\x10I\x87", "\xce\xa6\x8e\xce\xed%\xe8\xd2\x96\xae\x114\bE}:\xec", "\x1c\xc6\xb0\xf2V'\xd7\xf6n\xccZ\x93e\xeb\x1b,'g\xac"];
}

function getofffirevfxnames() {
  return ["\xcf\x8b\xf8\xcd\xbd\x87=p\xf2\xdf\xa5\xd5\xa1t\x96\xe21\xd4\x16\xbc", "/\xbac\xa0\x99\xa9D\x9ehL\r\xb9}\x88\x13\xc7\x87\xca", "8l\v\xe5\xac\x9c\xf5\xf6f3\xccZ\xe4Y\xafl\xc2'\x9d\xb2"];
}

function firedamagefxoff() {
  self.damage.firevfx delete();
  self.damage.firerumble delete();
  thread fadeoverlayanddestroy(self.damage.firedamageoverlay, 1);
  thread fadeoverlayanddestroy(self.damage.firepainoverlay, 1);
  thread fadesoundanddelete(self.damage.firesfx, 1);
  thread fadesoundanddelete(self.damage.firedronesfx, 1);
  thread fadesoundanddelete(self.damage.firesmolsfx, 1);
  thread removeradialdistortion(0.5);
}

function fadesoundanddelete(soundent, fadetime) {
  self endon("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");

  if(!isDefined(soundent)) {
    return;
  }

  soundent scalevolume(0, fadetime);
  wait fadetime;

  if(!isDefined(soundent)) {
    return;
  }

  soundent delete();
}

function fadeoverlayanddestroy(overlay, fadetime) {
  self endon("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");

  if(!isDefined(overlay)) {
    return;
  }

  overlay fadeovertime(fadetime);
  overlay.alpha = 0;
  wait fadetime;

  if(!isDefined(overlay)) {
    return;
  }

  overlay destroy();
}

function removefiredamageimmediate() {
  if(!utility::damageflag(32)) {
    return;
  }

  self notify("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");
  self.damage.firedamage = 0;

  if(utility::damageflag(16)) {
    setplayeroutoffire();
  }

  setplayerofffire();
}

function lerpoutfireintensity() {
  self endon("\x91\x85[\v\xd9\xb2\xf5fZ\x9cY");
  firedamagefloat = self.damage.firedamage;
  old_origin = level.player.origin;

  while(self.damage.firedamage > 0) {
    playermovespeed = length(old_origin - level.player.origin);
    var_5b3809031b6dbd8c = math::normalize_value(0, 10, playermovespeed);
    firedecaytime = math::factor_value(3.5, 3.5, var_5b3809031b6dbd8c);
    var_d5861846d9c85858 = 0.05 * 100 / firedecaytime;
    firedamagefloat -= var_d5861846d9c85858;
    firedamagefloat = clamp(firedamagefloat, 0, 100);
    self.damage.firedamage = math::round_float(firedamagefloat, 0);
    old_origin = level.player.origin;
    wait 0.05;
  }
}

function killplayer(attacker, type, inflictor, reason, amount, objweapon) {
  if(!val::get("\x1e\xfd\xd1\xa2\a")) {
    return;
  }

  if(getdvarint(@ "debug_deathsdoor") || isgodmode(self)) {
    return;
  }

  function_f9d154724c904dec(reason, amount);

  self enabledeathshield(0);
  self disableinvulnerability();

  if(isDefined(objweapon)) {
    self.overkillweapon = objweapon;
  }

  if(isDefined(inflictor) && isDefined(type)) {
    self kill(self.origin, attacker, inflictor, type);
    return;
  }

  if(isDefined(inflictor)) {
    self kill(self.origin, attacker, inflictor);
    return;
  }

  if(isDefined(type)) {
    self kill(self.origin, attacker, attacker, type);
    return;
  }

  self kill(self.origin, attacker);
}

function function_f56cd723243bcbc6(ignoredmods) {
  if(isstring(ignoredmods)) {
    ignoredmods = strtok(ignoredmods, "\x8c\xd3u");
  }

  level.armorignored = [];

  if(isarray(ignoredmods)) {
    foreach(mod in ignoredmods) {
      level.armorignored[mod] = 1;
    }
  }
}

function armorprotectsdamagetype(type, objweapon) {
  if(!isDefined(level.armorignored)) {
    if(isDefined(level.gamemodebundle.campaignlootlist)) {
      bundlelist = getscriptbundle("\x87eX\xbaayH\xa4h~{\xf4mk9\x16\xf8" + level.gamemodebundle.campaignlootlist);

      if(isDefined(bundlelist)) {
        function_f56cd723243bcbc6(bundlelist.var_d1808a94dcd31afa);
      }
    }
  }

  return !istrue(level.armorignored[type]);
}

function shouldkillimmediatly(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  if(shouldoverkill(overkilldamage, type)) {
    killplayer(attacker, type, inflictor, "\xbe\xc0q\x92o\x15\xf9\xb4\xd4\xbb\x8c\x03\x87D\xe8\xfa", overkilldamage, objweapon);
  }

  if(shouldkillmelee(attacker, type, inflictor)) {
    killplayer(attacker, type, inflictor, "\xb3M=\b\xad\x86R\t\xebzW\xd1\xf0\xc6\x84{c\xe4d\xf0c\xd7\xba\x98q");
  }

  if(function_d8396d93cc1b11d4(attacker, type, inflictor)) {
    killplayer(attacker, type, inflictor, "\x98h\xdc\xdf\xb0\x1dke>4\x90'Ls\x8c{`1\xae\xd6Y\xd5HO \x95r\n5\x02`_\x1e\x87");
  }

  if(shouldkillfalling(damage, type)) {
    killplayer(attacker, type, inflictor, "\xcfv\xd3\x8a:\xae\x030& 6p\x10", damage);
  }
}

function shouldoverkill(damage, type) {
  if(self.health != 1) {
    return false;
  }

  if(isexplosivedamage(type)) {
    overkillmodifier = 1;
  } else {
    overkillmodifier = self.damagemultiplier;
  }

  if(damage < 100 * overkillmodifier) {
    return false;
  }

  return true;
}

function shouldkillmelee(attacker, type, inflictor) {
  if(type == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    if(isDefined(attacker) && istrue(attacker.var_a6fe38e92d535d2f)) {
      return true;
    }

    if(utility::damageflag(1)) {
      return true;
    }
  }

  return false;
}

function function_d8396d93cc1b11d4(attacker, type, inflictor) {
  explosivetypes = ["\xd4zD\xebP%\xe9IEC\x15R\x13*", "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90", "\xa2rl\xdaDn\x17b\xd9I\xc9=N", "\x9az\x88\xfat)*\xe4\x14\x11\x15", "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a"];

  if(utility::damageflag(1) && arraycontains(explosivetypes, type)) {
    return true;
  }

  return false;
}

function shouldkillfalling(damage, type) {
  if(!isDefined(type)) {
    return false;
  }

  return type == "~<I\xc8\xe9\xd0Z\xf0\xbdRk" && damage == 100;
}

function damageinvulnerability(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  if(!shoulddodamageinvulnerabilty()) {
    return;
  }

  invulnerabletime = getinvultime();
  enabledamageinvulnerability();
  wait invulnerabletime;
  disabledamageinvulnerability();
}

function shoulddodamageinvulnerabilty() {
  if(utility::ent_flag("UGz\xa4\xbb\xd1R@\x11.\xa4\xf3\"\xfa\x82r\x02<\xf7\x9c\xac\x1c\x91\xa32\x1eH\x0f\x1e")) {
    return false;
  }

  if(self.health == 1) {
    return false;
  }

  if(utility::damageflag(1)) {
    return false;
  }

  return true;
}

function getinvultime() {
  return self.gs.invultime_ondamage;
}

function deathshieldinvulnerability(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  if(!shouldactivatedeathshield()) {
    return;
  }

  deathshieldtime = getdeathsshieldduration();
  deathsdoortime = getdeathsdoorduration();

  if(getdvarint(@ "debug_deathsdoor")) {
    deathsdoortime = 0;
  }

  utility::setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  self notify("J\a\xa7L\xabmA\xc9~\nr", deathshieldtime);
  now = gettime();
  deathshieldtimems = deathshieldtime * 1000;
  var_b247140c619f1478 = now - (self.damage.var_823c345bc5046088 ?? 0);
  var_e9d684e5403b2200 = now - (self.damage.var_57080e52961c8cf9 ?? 0);

  if(var_b247140c619f1478 < deathshieldtimems && var_e9d684e5403b2200 > level.frameduration && self.allowdeath != 0) {
    killplayer(attacker, type, inflictor, "]\xea\x15\xf0\xb5q\xfd\xe3\xd9\x9c\xab%\xde\xa3\xfd\xe6\x8c\xb5\f\x9a\x01\n\a\x85\x15\xb6", damage);
    return;
  }

  wait deathshieldtime;

  while(getdvarint(@ "debug_deathsdoor")) {
    waitframe();
  }

  var_122df6135640e324 = getDvar(@ "bg_falldamageminheight");

  if(val::get("\x1e\xfd\xd1\xa2\a")) {
    self enabledeathshield(0);
    childthread function_ae73e18783f8a426();
    maxfall = getdvarfloat(@ "bg_falldamagemaxheight", 375);
    setsaveddvar(@ "bg_falldamageminheight", int(maxfall - 1));
  }

  utility::setdamageflag(1, 0);
  self.damage.var_823c345bc5046088 = gettime();
  disabledamageinvulnerability();
  wait deathsdoortime;
  self notify("\"}\xc5\x14\xfa\xb2\xad75T\x17H\xc2\xe9Y\x8e\xe5~");
  disabledeathsdoor();
  self enabledeathshield(1);
  setsaveddvar(@ "bg_falldamageminheight", int(var_122df6135640e324));
}

function private function_ae73e18783f8a426() {
  self notify("\xb5C\t(7F\xff \x0fp\xa5'\x10}\x12S");
  self endon("\xb5C\t(7F\xff \x0fp\xa5'\x10}\x12S");
  self endon("\"}\xc5\x14\xfa\xb2\xad75T\x17H\xc2\xe9Y\x8e\xe5~");
  deathshieldenabled = undefined;

  while(utility::damageflag(2)) {
    if(hasarmor() && !istrue(deathshieldenabled)) {
      self enabledeathshield(1);
      deathshieldenabled = 1;
    } else if(!hasarmor() && istrue(deathshieldenabled)) {
      self enabledeathshield(0);
      deathshieldenabled = undefined;
    }

    waitframe();
  }
}

function getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

function getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

function enabledeathsdoor() {
  if(istrue(self.disabledeathsdoor)) {
    return;
  }

  self.deathsdoor = 1;
  self enableplayerbreathsystem(0);
  self notify("_\xbb\x82\x86!\x93\x15\xaa\xed3\xf2\xd9\x0f\x9b\xa8\xa3p\xafW");
  utility::setdamageflag(2, 1);
  thread audio::set_deathsdoor();
  early_fade = 0.5;
  overlaytime = getdeathsshieldduration() + getdeathsdoorduration() + gethealthregentime() - early_fade;
  thread deathsdooroverlaypulse(overlaytime);
  fadetime = 0.5;
  holdtime = overlaytime - fadetime;
  thread bloodoverlay(1, holdtime, fadetime);
  updatedeathsdoorvisionset();
  self painvisionon();
}

function updatedeathsdoorvisionset() {
  if(!utility::damageflag(2)) {
    return 0;
  }

  visionsetname = "";
  postfxbundlename = undefined;

  if(level.player isnightvisionon()) {
    visionsetname = self.damage.var_de9d9de0c86e326e ?? "'\xd4\xc9\xd7SE\a64\xf6\xcd\xb2\x95M\xa41\v%H5S";
  } else {
    visionsetname = self.damage.var_9ed7fdf619e68ea1 ?? "\xb2!N\xca\xf0;\xbd\xbdz;)\xcc\x97\x87Z\x01A";
    postfxbundlename = level.gamemodebundle.pbgpostfxbundle_pain;
  }

  [[level.sharedfuncs[#"fullscreenfx"][#"setpain"]]]({
    #postfxbundlename: postfxbundlename, #visionsetname: visionsetname
  });
}

function disabledeathsdoor(instant) {
  self notify("k\xb3Yz.\xe8\xd6\xc3\xe0{\xb3\x88\xe9\xe4r\x9a1");
  self endon("k\xb3Yz.\xe8\xd6\xc3\xe0{\xb3\x88\xe9\xe4r\x9a1");

  if(!isDefined(instant)) {
    instant = 0;
  }

  if(!instant) {
    lerpouttime = gethealthregentime();
    thread audio::restore_after_deathsdoor(lerpouttime * 0.2);
  } else {
    lerpouttime = 0;
  }

  lerpoutrate = getvisionlerprate(lerpouttime);
  setsaveddvar(@ "hash_e42b132626b5992b", lerpoutrate);
  self painvisionoff();
  self enableplayerbreathsystem(1);
  self.deathsdoor = 0;
  utility::setdamageflag(2, 0);
}

function lerpdeathsdoorpulsenorm(outtime) {
  self notify("\xed\xa5Brdbel`OE\x0fab\x0e\xef\xf2-");
  self endon("\xed\xa5Brdbel`OE\x0fab\x0e\xef\xf2-");
  self endon("\x1e\xfd\xd1\xa2\a");
  timer = outtime;
  self.deathsdoorpulsenorm = 1;

  while(timer > 0) {
    self.deathsdoorpulsenorm = math::normalize_value(0, outtime, timer);
    self.deathsdoorpulsenorm = math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    timer -= 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

function enabledamageinvulnerability() {
  utility::ent_flag_set("UGz\xa4\xbb\xd1R@\x11.\xa4\xf3\"\xfa\x82r\x02<\xf7\x9c\xac\x1c\x91\xa32\x1eH\x0f\x1e");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

function disabledamageinvulnerability() {
  utility::ent_flag_clear("UGz\xa4\xbb\xd1R@\x11.\xa4\xf3\"\xfa\x82r\x02<\xf7\x9c\xac\x1c\x91\xa32\x1eH\x0f\x1e");
  gameskill::update_player_attacker_accuracy();
}

function shouldactivatedeathshield() {
  if(getdvarint(@ "debug_deathsdoor") && !istrue(level.audio.in_deathsdoor)) {
    return true;
  }

  if(self.health != 1) {
    return false;
  }

  if(utility::damageflag(1)) {
    return false;
  }

  if(utility::damageflag(2)) {
    return false;
  }

  return true;
}

function regeneratehealth(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\n,p\x0f\aG\xaf\xa7\x99\\\x17\xa51\xec\x817\xfc\xce\x8d\n\xe5K+\r\x16\xf4");
  self endon("\n,p\x0f\aG\xaf\xa7\x99\\\x17\xa51\xec\x817\xfc\xce\x8d\n\xe5K+\r\x16\xf4");
  self endon("3G\x12\xa4\xe5\xb5\xd8\x90J\x17Oo\xc7d\xc3");

  if(!canregenhealth()) {
    return;
  }

  regendelay = gethealthregendelay();
  self.currentregendelay = regendelay;
  regeneratehealthwait(regendelay);

  while(utility::damageflag(32)) {
    if(!canregenhealth()) {
      return;
    }

    waitframe();
  }

  finalhealth = self.health;

  while(self.health < self.maxhealth) {
    if(!canregenhealth()) {
      return;
    }

    self.damage.var_57080e52961c8cf9 = gettime();
    var_907b0bc7700fc654 = gethealthregenpersecond();
    frameregen = var_907b0bc7700fc654 * 0.05;
    finalhealth = clamp(finalhealth + frameregen, 0, self.maxhealth);
    set_normalhealth(finalhealth / self.maxhealth);
    waitframe();
  }
}

function private regeneratehealthwait(regendelay) {
  self endon("\x92j\xef\xf1\x85>\x98m\xde^\xd8\xa2A\xbcZt\xe4Oz\xde\xefn");
  wait regendelay;

  while(utility::damageflag(2)) {
    waitframe();
  }
}

function gethealthregenpersecond() {
  return self.gs.healthregenrate * self.gs.var_9a45caab4d484b5;
}

function getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

function getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

function gethealthregentime() {
  regenamount = self.maxhealth - self.health;
  var_a5564ed9f32dd893 = regenamount / gethealthregenpersecond();
  return var_a5564ed9f32dd893;
}

function gethealthregendelay() {
  return self.gs.healthregendelay * self.gs.var_8c2fe6dcd2893a1a;
}

function canregenhealth() {
  if(istrue(self.disable_health_regen)) {
    return false;
  }

  if(isDefined(self.gs.armorratiohealthregenthreshold) && armorratio() > self.gs.armorratiohealthregenthreshold) {
    return false;
  }

  return true;
}

function damageeffects(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  effectfunctions = [ &damagesfx, &damagerumble, &damageradialdistortion, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damagebloodoverlay, &damageshock];
  factor = damageratio(damage);

  foreach(function in effectfunctions) {
    self childthread[[function]](point, factor, type);
  }
}

function damagesfx(origin, factor, type) {
  self endon("\xbe\x8b\x851=\xa5 \x8eK\x13EP\x13");
  type = "\x13\x1e\xe31{\xb4\xf1\x85\x18";
  impactsfx = getimpactsfx(type);
  yellsfx = getvocalpainsfx(type);

  if(isDefined(impactsfx)) {
    self.damage.impactsfx playSound(impactsfx);
  }

  if(armorbroke()) {
    self.armor.sfx playSound("\xe0L\x05x=\xb7\xdat\xec\x04\xbb\x86\xa0\x9f");
  }

  wait 0.25;

  if(!utility::damageflag(4)) {
    volume = math::factor_value(0.75, 1.75, factor);
    self.damage.impactsfx scalevolume(volume);
    self.damage.impactsfx playSound(yellsfx);
    utility::setdamageflag(4, 1);
    utility::delaythread(3, &utility::setdamageflag, 4, 0);
  }
}

function getimpactsfx(type) {
  if(!hasarmor()) {
    if(type == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
      return;
    }

    return "\x1c\xd8r\xd7\x1c'{\xd1\xb7_\x13\xab\xb1\xc6\xac\xa3\xaf\xa5m\aa6\xa3";
  }

  return "0\x88\xc7\xdd\x84@\x8fE:\xf1\nc\xf8Zp\xec^\x85F\xc0:x\xa7\xa3\xa8\xda\x80\xd2\xa9";
}

function getvocalpainsfx(type) {
  if(!hasarmor()) {
    return "\xc4=^\x8f\xc6\xe6\x90\xcd\x18\x98\xe3\xc2\r\x8b\x85f\xfd\x83\xac9";
  }

  return "a\xedtRTR6yjt\xa6}1\x14}N\xb0Z\f\xd6]";
}

function stopimpactsfx() {
  self.damage.impactsfx stopsounds();
}

function damageshock(origin, factor, type) {
  if(isexplosivedamage(type) && !istrue(self.disableexplosiveshellshock)) {
    duration = math::factor_value(3, 3, factor);
    self shellshock("+\x1e\x1c\xd8\xbds\xd2{\xb9", 3);
  }
}

function damagerumble(origin, factor, type) {
  if(factor > 0.4) {
    self playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
    return;
  }

  self playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
}

function damagescreenshake(origin, factor, type) {
  pitch = math::factor_value(0.82, 1.2, factor);
  yaw = math::factor_value(0.65, 0.8, factor);
  roll = math::factor_value(0.68, 1.25, factor);
  duration = math::factor_value(1.12, 1.85, factor);
  durationup = math::factor_value(0.1, 0.32, factor);
  durationdown = duration - durationup - 0.05;

  if(isexplosivedamage(type)) {
    pitch *= 5;
    yaw *= 5;
    roll *= 5;
  }

  screenshake(origin, pitch, yaw, roll, duration, durationup, durationdown, 0, 1, 0.5, 1);

  if(armorbroke()) {
    earthquake(0.3, 0.65, self.origin, 5000);
  }
}

function damageradialdistortion(origin, factor, type) {
  self endon("\x02\xdd\xd8\xf35\xb52\xbe\xe0-\xde\xdd\x8b\x9f\xa0\x8e");

  if(utility::damageflag(32)) {
    return;
  }

  distortion = math::factor_value(0.045, 0.045, factor);
  strength = math::factor_value(0.09, 0.09, factor);
  outtime = math::factor_value(0.2, 0.2, factor);
  radial_distortion(distortion, strength, outtime, origin);
}

function removeradialdistortion(outtime) {
  childthread utility_sp::lerp_saveddvar(@ "r_mbradialoverridedistortion", 0, outtime);
  childthread utility_sp::lerp_saveddvar(@ "r_mbradialoverrideradius", 0, outtime);
  childthread utility_sp::lerp_saveddvar(@ "r_mbradialoverridestrength", 0, outtime);
  childthread utility_sp::lerp_saveddvar(@ "hash_bc02f8e41595c9a8", 0, outtime);
}

function damagepainvision(origin, factor, type) {
  self endon("\xbe\x8b\x851=\xa5 \x8eK\x13EP\x13");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!shoulddopainvision()) {
    return 0;
  }

  visionsetname = "";
  postfxbundlename = undefined;

  if(!hasarmor()) {
    if(level.player isnightvisionon()) {
      visionsetname = self.damage.var_7d4a2ed9ee8b56b5 ?? "l\xc1\xd7\xce0;\x17\xfc,\xe3";
    } else {
      visionsetname = self.damage.scriptedpainvision ?? "@<\x8d\xef\xea\x17B\xb9|\a\xc6\x83\b";
      postfxbundlename = level.gamemodebundle.var_5be0bb0f8a57c4b2;
    }

    lerpin = math::factor_value(0, 0, factor);
    lerpout = math::factor_value(1.9, 1.9, factor);
    holdtime = math::factor_value(0.05, 0.05, factor);
  } else {
    visionsetname = self.damage.var_b0db8450cbf46cbb ?? "\x80\x15\x80\xe0}\x06\xd3\x1aK\xbf\xafh";
    lerpin = math::factor_value(0, 0, factor);
    lerpout = math::factor_value(1.9, 1.9, factor);
    holdtime = math::factor_value(0.05, 0.05, factor);
  }

  [[level.sharedfuncs[#"fullscreenfx"][#"setpain"]]]({
    #postfxbundlename: postfxbundlename, #visionsetname: visionsetname
  });
  setsaveddvar(@ "hash_b61c9c6a24b5671e", lerpin);
  setsaveddvar(@ "hash_e42b132626b5992b", lerpout);
  self painvisionon();
  wait holdtime;
  self painvisionoff();
}

function shoulddopainvision() {
  if(utility::damageflag(2)) {
    return false;
  }

  if(self.health == 1) {
    return false;
  }

  if(istrue(self.disablepainvision)) {
    return false;
  }

  return true;
}

function damagebloodoverlay(origin, factor, type) {
  if(self.damage.healthdamage > 0) {
    damagebloodoverlaydirectional(origin, type);
    damagebloodoverlayfullscreen(origin, factor, type);
  }
}

function damagebloodoverlaydirectional(origin, type, outtime) {
  if(utility::iswegameplatform()) {
    return;
  }

  time = gettime();

  if(time - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = time;
  }

  explosivetypes = ["\xd4zD\xebP%\xe9IEC\x15R\x13*", "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90", "\xa2rl\xdaDn\x17b\xd9I\xc9=N", "\x9az\x88\xfat)*\xe4\x14\x11\x15", "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a"];
  sides = getplayersidesfromposition(origin);
  materialsuffix = "";

  if(isDefined(self.damage.var_8492fa63b307ff8f)) {
    prefix = self.damage.var_8492fa63b307ff8f;
  } else if(arraycontains(explosivetypes, type)) {
    prefix = "%B#\xae\xb9\xa8]\xfa\xd5W\xbd\x9a+\xd6r\x02";
  } else if(!hasarmor()) {
    prefix = "5\x1dAm-\xdf\xf3\x9d\xc5E@\xe0\xd9\x8f\x88\xf7\x17";

    if(self.damage.altdirectionalbloodoverlay) {
      materialsuffix = "\xae\xd7D\xd8";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    prefix = "\xaa\x88\xc0\x13#\xe26a86T\xf1*\xac\xb1\x01%";
  }

  if(!isDefined(outtime)) {
    outtime = 2;
  }

  foreach(side, type in sides) {
    material = prefix + side;
    splashmaterial = material + "2Sa\x1a\x1f#\x84";
    material += materialsuffix;
    randomoffsets = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffectext(side, material, 0.15, outtime, randomoffsets, 1, 1);
    createscreeneffectext(side, splashmaterial, 0.15, 0.15, randomoffsets, 0, 1);
  }
}

function damagebloodoverlayfullscreen(origin, factor, type) {
  if(utility::damageflag(2)) {
    return;
  }

  bloodalpha = math::factor_value(0.8, 0.3, healthratio());
  holdtime = gethealthregendelay();
  fadetime = gethealthregentime();
  thread bloodoverlay(bloodalpha, holdtime, fadetime);
}

function isexplosivedamage(type) {
  explosivetypes = ["\x9az\x88\xfat)*\xe4\x14\x11\x15", "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a", "\xd4zD\xebP%\xe9IEC\x15R\x13*", "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90", "\xa2rl\xdaDn\x17b\xd9I\xc9=N"];
  return arraycontains(explosivetypes, type);
}

function isspreadweapon(objweapon) {
  return isDefined(objweapon) && weaponclass(objweapon) == "\n\x1f+\x8dob";
}

function createscreeneffectoffsets(x, y, scale) {
  offsets = [];
  offsets["<"] = x;
  offsets["m"] = y;
  offsets["\x93\"X\xef&"] = scale;
  return offsets;
}

function createscreeneffect(side, shader, intime, outtime, randomoffsets, fadein) {
  createscreeneffectext(side, shader, intime, outtime, randomoffsets, fadein, 0);
}

function createscreeneffectext(side, shader, intime, outtime, randomoffsets, fadein, lowres) {
  hud = newclienthudelem(self);
  hud.sort = 13;
  hud.foreground = 0;
  hud.lowresbackground = lowres;
  hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.alpha = 0;
  hud.enablehudlighting = 1;
  x = 0;
  y = 0;
  finalx = 0;
  finaly = 0;
  finalscale = math::factor_value(0.9, 1.25, randomoffsets["\x93\"X\xef&"]);

  switch (side) {
    case #"hash_c9b3133a17a3b2d0":
      hud.aligny = "\x1d Q";
      hud.alignx = "=\xff0b";
      x = -640;
      y = math::factor_value(-30, 30, randomoffsets["m"]);
      finaly = y;
      finalx = math::factor_value(-55, 0, randomoffsets["<"]);
      break;
    case #"hash_96815ce4f2a3dbc5":
      hud.aligny = "\x1d Q";
      hud.alignx = "o0\xee\xc1\x8c";
      x = 1280;
      y = math::factor_value(-30, 30, randomoffsets["m"]);
      finaly = y;
      finalx = math::factor_value(0, 55, randomoffsets["<"]) + 640;
      break;
    case #"hash_dcbcc9b3083fb78a":
      hud.aligny = "\x14#\x01\x89\f\x81";
      hud.alignx = "=\xff0b";
      y = 960;
      x = math::factor_value(-50, 50, randomoffsets["<"]);
      finaly = math::factor_value(0, 50, randomoffsets["m"]);
      finaly += 480;
      finalx = x;
      break;
  }

  hud.x = x;
  hud.y = y;
  hud setshader(shader, 640, 640);
  thread screeneffectcleanup(hud);
  thread animatescreeneffect(hud, intime, outtime, finalx, finaly, finalscale, fadein);
}

function animatescreeneffect(hud, intime, outtime, x, y, scale, fadein) {
  hud endon("\f\xdf\x03e\x9c\xbb\xd9+\xbddC*,H\xe8\xbcU\xae\xf6\xcb:\x12\xa6\x84\x1e");

  if(!fadein) {
    hud scaleovertime(intime, int(640 * scale), int(480 * scale));
    hud moveovertime(intime);
    hud.x = x;
    hud.y = y;
    intime = 0.05;
    hud.alpha = 1;
    wait 0.05;
  } else {
    hud scaleovertime(intime, int(640 * scale), int(480 * scale));
    hud.x = x;
    hud.y = y;
    wait 0.15;
    hud fadeovertime(intime);
    hud.alpha = 1;
    wait intime;
  }

  hud fadeovertime(outtime);
  hud.alpha = 0;
  wait outtime + 0.05;
  hud notify("\f\xdf\x03e\x9c\xbb\xd9+\xbddC*,H\xe8\xbcU\xae\xf6\xcb:\x12\xa6\x84\x1e");
}

function screeneffectcleanup(hud) {
  self.damage.activescreeneffectoverlays = utility::array_add(self.damage.activescreeneffectoverlays, hud);
  hud waittill("\f\xdf\x03e\x9c\xbb\xd9+\xbddC*,H\xe8\xbcU\xae\xf6\xcb:\x12\xa6\x84\x1e");
  self.damage.activescreeneffectoverlays = arrayremove(self.damage.activescreeneffectoverlays, hud);
  hud destroy();
}

function updatedamageoverlay(origin, factor, type) {
  self endon("\xbe\x8b\x851=\xa5 \x8eK\x13EP\x13");
  self endon("\x02\xdd\xd8\xf35\xb52\xbe\xe0-\xde\xdd\x8b\x9f\xa0\x8e");
  armor_broke = armorbroke();

  if(isDefined(self.damage.scriptedoverlay)) {
    self.damage.overlay setshader(self.damage.scriptedoverlay, 640, 480);
    multiplier = 0.6;
  } else if(armor_broke) {
    multiplier = 0;

    if(!isDefined(self.damage.armorvfx)) {
      self.damage.armorvfx = utility::spawn_tag_origin();
      self.damage.armorvfx function_7ec33711a0892c((50, 0, 0));
    }

    playFXOnTag(level.g_effect["z<\x82\xb1\xf1\xf9\xa7O\x95\x90n6d\xcfh\x1ek\v"], self.damage.armorvfx, "\xec\xbfK|\au\xcd\xc2\x19<");
  } else if(!hasarmor()) {
    self.damage.overlay setshader("\x1e\x16\x1e\xf4\xcb\x03\xae?E\x19\x01\xf3\xd0H\xcf?\xafs\xe75[\t0m\x7fo\f\x01O", 640, 480);
    multiplier = 0.8;
  } else {
    self.damage.overlay setshader("\x1e\x16\x1e\xf4\xcb\x03\xae?E\x19\x01\xf3\xd0H\xcf?\xafs\xe75[\t0m\x7fo\f\x01O", 640, 480);
    multiplier = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, multiplier);
  wait 0.05;

  if(armor_broke) {
    fadeouttime = 1;
  } else {
    fadeouttime = math::factor_value(0.2, 0.2, factor);
  }

  if(!hasarmor()) {
    self.damage.overlay childthread function_93d3cce2b2d67db5(self);
    return;
  }

  self.damage.overlay fadeovertime(fadeouttime);
  self.damage.overlay.alpha = 0;
}

function deathsdooroverlaypulse(overlaytime) {
  self notify("\xdf\v\x8a\xdbP\x0438\xb8\xf4|c\xd0\x89C");
  self endon("\xdf\v\x8a\xdbP\x0438\xb8\xf4|c\xd0\x89C");
  self endon("\x02\xdd\xd8\xf35\xb52\xbe\xe0-\xde\xdd\x8b\x9f\xa0\x8e");
  self endon("\x1e\xfd\xd1\xa2\a");
  pulsealpha = 1;
  thread lerpdeathsdoorpulsenorm(overlaytime);

  while(pulsealpha > 0) {
    time = gettime();
    pulsestarttime = time;
    pulseduration = math::factor_value(1000, 600, self.deathsdoorpulsenorm);

    while(time < pulsestarttime + pulseduration) {
      time = gettime();
      pulsealphamin = 0.1;
      pulsealphamax = 0.4;
      pulsenormalized = (time - pulsestarttime) / pulseduration;
      pulsefraction = math::normalized_cos_wave(pulsenormalized);
      pulsealpha = math::factor_value(pulsealphamin, pulsealphamax, pulsefraction);
      pulsealpha *= self.deathsdoorpulsenorm;
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
      waitframe();
    }
  }
}

function deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

function bloodoverlay(alpha, holdtime, fadetime) {
  if(utility::iswegameplatform() || !shoulddopainvision()) {
    return;
  }

  minfadetime = 0.5;

  if(fadetime <= minfadetime) {
    fadetime = minfadetime;
  }

  self notify("\f\xfe\xb4\xae Vz\x11 \xae\xcfp\x92p\x810\x8c");
  self endon("\f\xfe\xb4\xae Vz\x11 \xae\xcfp\x92p\x810\x8c");
  self endon("\x02\xdd\xd8\xf35\xb52\xbe\xe0-\xde\xdd\x8b\x9f\xa0\x8e");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = alpha;
  wait holdtime;
  self.damage.bloodoverlay childthread function_93d3cce2b2d67db5(self);
}

function private function_93d3cce2b2d67db5(player) {
  self notify("4l\x9cj0\xcd13Nf\x86\f,75\xa6");
  self endon("4l\x9cj0\xcd13Nf\x86\f,75\xa6");
  startalpha = self.alpha;

  while(self.alpha > 0.05) {
    alpha = min(startalpha, 1 - player healthratio());
    self fadeovertime(level.framedurationseconds);
    self.alpha = alpha;
    wait level.framedurationseconds;
  }

  self fadeovertime(level.framedurationseconds);
  self.alpha = 0;
}

function playpulsesfx(pulseduration) {
  pulsevolume = math::normalized_to_growth_clamps(0, 1, self.deathsdoorpulsenorm);
  pulsedelay = pulseduration * 0.8 / 1000;
  self.damage.pulsesfx scalevolume(pulsevolume);
  wait pulsedelay;
  self.damage.pulsesfx stopsounds();
  self.damage.pulsesfx playSound("%\xf79\xa6\xbe\xa6\xe9!a\xdd\xff\xbcn:\xf2");
}

function shoulddohealthdamageeffects(type) {
  if(isDefined(type) && !armorprotectsdamagetype(type)) {
    return true;
  }

  return true;
}

function getplayersidesfromposition(position) {
  forwardvec = vectorNormalize(anglesToForward(self.angles));
  rightvec = vectorNormalize(anglestoright(self.angles));
  var_11a31f557be843ce = vectorNormalize((position[0], position[1], 0) - (self.origin[0], self.origin[1], 0));
  fdot = vectordot(var_11a31f557be843ce, forwardvec);
  rdot = vectordot(var_11a31f557be843ce, rightvec);
  sides = [];

  if(abs(fdot) > 0.819152) {
    sides["\x14#\x01\x89\f\x81"] = 1;
  } else if(rdot > 0) {
    sides["o0\xee\xc1\x8c"] = 1;
  } else {
    sides["=\xff0b"] = 1;
  }

  return sides;
}

function function_ab562ee55e6bb2(armoramount) {
  return (armoramount - armoramount % 33) % 32;
}

function function_1d86c408ed27cec2() {
  if(self getclientomnvar("N\xb8\x9f4\x9aqsx\x10uB\xcb\xbb\xe4t%\xfa\xb4Tu\xcb&C\x8c$b3z6\xbc\xe3") > 0) {
    return true;
  }

  return false;
}

function private updatearmorui() {
  self notify("6\n\x02F5\"{\x97\xe3w#UQ\xb7{|");
  self endon("6\n\x02F5\"{\x97\xe3w#UQ\xb7{|");
  waittillframeend();
  var_b066860c4fa1b5cd = armorratio();
  self setclientomnvar("\xab\xd2\xeb\xb0\x9cm\xf6\x93}\x0e\xacr\xc6Yn\xd1", var_b066860c4fa1b5cd);
  armoramount = getarmormaxamount();
  numplates = function_ab562ee55e6bb2(armoramount);
  self setclientomnvar("\\\xa5q\xb7X\xd4U\x8c\xe5\xad\xcaP\x14\xa1\\\xf8\xe8E\xc0\x06PS5d\xb4Y\b", int(numplates));
  self setclientomnvar("\x8a\xf5\x01T\x17r\xb7}9\x86LTU\x84\xb04\xe2T\xdf\xbe\xd6v\xbbq\xc6\x1bu]\xdd\x87l\xa1", function_9828b76d9dcaef2d());
  self setclientomnvar("f/\xe5\x17>-`9D\xcd\xcb`{g-\rZ\x8eY\x8b\xe9\x11\xa2d\xf92\xdd\xe1\xc7\xef)d", function_b77a5b6ee26de43());
  self setclientomnvar("\xf3\xdcP=\xf7+m\xffEk\xf8\x8ea\xc4>\v\xab", 0);
  self setclientomnvar("N\xb8\x9f4\x9aqsx\x10uB\xcb\xbb\xe4t%\xfa\xb4Tu\xcb&C\x8c$b3z6\xbc\xe3", function_ab562ee55e6bb2(self.armor.maxamount));
  self setclientomnvar("\xb3\xcb\x13h\x04\xc4\xea\x84\x88\xb5\x18\x02\xc2h\xcd\xabs\xcc\x02m\x1f\xbc\xd9\xec{\xca\a\x04\xad6\xdd\xfd\xf0", self.armor.plates);

  if(function_a9817b6e19b16060()) {
    self setclientomnvar("\xf8xAhz\r@\xa6\xe4\x1d\x12\xbe8", "|\x05.\xa3\x91\x10\xbe\xe5\x91");
  } else {
    self setclientomnvar("\xf8xAhz\r@\xa6\xe4\x1d\x12\xbe8", "\xa3{s\x88\x9c*\x01\xcf\x97\x10");
  }

  if(hasarmor() && function_1d86c408ed27cec2()) {
    self setclientomnvar("\xf3\xc0\xf6\x9c|_\xbfU\x0f\x85N,\x80\xb4\xc6\xdb\xff\xc6", 0);

    if(haslowarmor()) {
      self setclientomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa6 \x05\xf9\xee\n\x8d\xd3\x8a");
    } else {
      self setclientomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa3{s\x88\x9c*\x01\xcf\x97\x10");
    }

    return;
  }

  self setclientomnvar("\xf3\xc0\xf6\x9c|_\xbfU\x0f\x85N,\x80\xb4\xc6\xdb\xff\xc6", 0.75);
  self setclientomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa2\xb1\xcd\x15\xf3\xa3\xb0|");
}

function function_a9817b6e19b16060() {
  if(self ismantling() || self ishanging()) {
    return false;
  }

  if(!hasarmor() && function_b77a5b6ee26de43() && !usingarmorplate() && function_1d86c408ed27cec2() && caninsertarmor()) {
    return true;
  }

  return false;
}

function gettakecoverwarnings() {
  takecoverwarnings = 0;

  if(getprojectname() == "\x99\x0f\xab") {
    takecoverwarnings = self getplayerprogression("wW\xe10\x12X\xd3\v\xb0G\xfa|4Hv\xb7\x84");
  } else {
    takecoverwarnings = self getlocalplayerprofiledata("wW\xe10\x12X\xd3\v\xb0G\xfa|4Hv\xb7\x84");
  }

  return takecoverwarnings;
}

function settakecoverwarnings(count) {
  if(getprojectname() == "\x99\x0f\xab") {
    self setplayerprogression("wW\xe10\x12X\xd3\v\xb0G\xfa|4Hv\xb7\x84", count);
    return;
  }

  self setlocalplayerprofiledata("wW\xe10\x12X\xd3\v\xb0G\xfa|4Hv\xb7\x84", count);
}

function playeroffhandmain() {
  self endon("\x1e\xfd\xd1\xa2\a");
  childthread offhands::offhandfiremanager();
}

function armorplateusetype() {
  player = level.player;

  if(player utility::is_player_gamepad_enabled()) {
    selection = player getlocalplayerprofiledata("\xda\xb4\xb6{Smu\xac\xcc@\x95<\xb6\x16\t\xb4\xa1\xde\xd9\xcbHZ");

    switch (selection) {
      case 1:
        return 2;
      default:
        return 1;
    }

    return;
  }

  selection = player getlocalplayerprofiledata("^\x83\x9dA\xc4\xfb\x9fM\xa5\x82\v6EE\x85\xc6\xe1H");

  switch (selection) {
    case 2:
      return 1;
    case 1:
      return 2;
    default:
      return 0;
  }
}

function usearmorplateinput() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(",1\xcc\x9bZ\xd5\x05\xf8\x1b\x82\x05O\x11{e!\xd1\x12>\xe7\xb5V");
  childthread function_b06e714b7e665a11();
  childthread function_8379cb7e9fa6123c();
  childthread function_b208ab64f364c616();

  while(utility::playerarmorenabled()) {
    self notifyonplayercommand("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8", "b\xc8\x95\xf9OS");
    self notifyonplayercommand("+wA\xf2\xc5\x1d\f\x04\xa9'\x7f\xb7\xf7a", "\xf6\x9fjs\xbe\xf2");
    self waittill("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8");
    usetype = armorplateusetype();
    self.armor.buttonreleased = undefined;
    var_e906256f0478cf85 = usetype === 1;

    while(!istrue(self.armor.buttonreleased)) {
      tryusearmor();

      if(!var_e906256f0478cf85) {
        break;
      }

      waitframe();
    }
  }

  self notifyonplayercommandremove("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8", "b\xc8\x95\xf9OS");
  self notifyonplayercommandremove("+wA\xf2\xc5\x1d\f\x04\xa9'\x7f\xb7\xf7a", "\xf6\x9fjs\xbe\xf2");
  self notify(",1\xcc\x9bZ\xd5\x05\xf8\x1b\x82\x05O\x11{e!\xd1\x12>\xe7\xb5V");
}

function private function_b06e714b7e665a11() {
  framesheld = 0;
  framesrequired = 5;
  var_4d64f7e4935aee47 = 0;

  while(true) {
    waitframe();

    if(!self usinggamepad() || !self weaponswitchbuttonPressed()) {
      framesheld = 0;
      var_4d64f7e4935aee47 = 0;

      if(self usinggamepad()) {
        self.armor.buttonreleased = 1;
      }

      self setclientomnvar("\xf3\xdcP=\xf7+m\xffEk\xf8\x8ea\xc4>\v\xab", 0);
      continue;
    }

    framesheld++;

    if(!istrue(self.armor.buttonreleased) && caninsertarmor()) {
      self setclientomnvar("\xf3\xdcP=\xf7+m\xffEk\xf8\x8ea\xc4>\v\xab", framesheld / framesrequired);
    }

    if(framesheld >= framesrequired && !var_4d64f7e4935aee47) {
      self notify("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8");
      framesheld = 0;
      var_4d64f7e4935aee47 = 1;
      self setclientomnvar("\xf3\xdcP=\xf7+m\xffEk\xf8\x8ea\xc4>\v\xab", 0);
    }
  }
}

function private function_8379cb7e9fa6123c() {
  while(true) {
    self waittill("+wA\xf2\xc5\x1d\f\x04\xa9'\x7f\xb7\xf7a");
    self.armor.buttonreleased = 1;
  }
}

function private function_b208ab64f364c616() {
  self.armor.buttonpresscount = 0;

  while(true) {
    self waittill("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8");

    if(caninsertarmor()) {
      self.armor.buttonpresscount += 1;
    } else {
      self.armor.buttonpresscount = 0;
    }

    if(getdvarint(@ "hash_d8e69627073e0766")) {
      iprintln("<dev string:x299>" + self.armor.buttonpresscount);
    }
  }
}

function tryusearmor() {
  if(!istrue(utility::playerarmorenabled())) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  if(!playercanusearmorplate()) {
    level.player setclientomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa3{s\x88\x9c*\x01\xcf\x97\x10");
    waitframe();

    if(hasmaxarmor()) {
      return;
    }

    if(function_b77a5b6ee26de43() == 0) {
      level.player setclientomnvar("d\a~\x1b\xe8#\xa3Q\x87\xf3D\xf7\xde/<\xa2", "\xa2\xb1\xcd\x15\xf3\xa3\xb0|");
    }

    return;
  }

  thread function_e35303e7a4d36224();
}

function playercanusearmorplate() {
  if(usingarmorplate()) {
    return false;
  }

  if(!caninsertarmor()) {
    return false;
  }

  return true;
}

function private caninsertarmor() {
  if(!isalive(self) || self isparachuting() || self isskydiving() || self isonladder() || self ismantling() || self ishanging() || self isusingturret()) {
    return false;
  }

  if(self ismeleeing() || self isthrowinggrenade()) {
    return false;
  }

  if(!val::get("\xf7~{\xb1\x14")) {
    return false;
  }

  if(!getdvarint(@ "hash_bfa6bedc37206c58")) {
    return false;
  }

  if(hasmaxarmor()) {
    return false;
  }

  if(function_421fb62426747763() && !function_b77a5b6ee26de43()) {
    return false;
  }

  if(isDefined(self.veh) && self.veh.driver == self) {
    return false;
  }

  return true;
}

function function_9a088885bdb90ef6() {
  if(!isDefined(level.armorobjweapon) && isDefined(level.loot.armorplateweapon)) {
    level.armorobjweapon = makeweapon(level.loot.armorplateweapon);
  }

  return level.armorobjweapon;
}

function function_16ca171339b44156() {
  if(!isDefined(level.armorobjweaponoffhand) && isDefined(level.loot.armorplateoffhand)) {
    level.armorobjweaponoffhand = makeweapon(level.loot.armorplateoffhand);
  }

  return level.armorobjweaponoffhand;
}

function private armorplateprestream() {
  if(!isplatformps4()) {
    return;
  }

  precachemodel("RN\xf6\x9c\xb83\x89\x05F}\x1b\xe7G<\x0f$\xf2\x13\xfb\xd6\xec\x8a");
  precachemodel("+\\\x1c\xbe\xd11`\xfa\xd9k\xf5ar\xb5\xed9\xbe\x1c\xb1a\xd1\xac");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    waittillframeend();

    if(playercanusearmorplate() && !istrue(self.player_prestream_assets_thread["\xff\xb2\x0e\xc5\xc8"])) {
      platemodel = "RN\xf6\x9c\xb83\x89\x05F}\x1b\xe7G<\x0f$\xf2\x13\xfb\xd6\xec\x8a";

      if(istrue(self.armor.useoffhand)) {
        platemodel = "+\\\x1c\xbe\xd11`\xfa\xd9k\xf5ar\xb5\xed9\xbe\x1c\xb1a\xd1\xac";
      }

      utility::function_c47b5325ebd03f27("\xff\xb2\x0e\xc5\xc8", platemodel, 5);
    }

    waitframe();
  }
}

function private function_e35303e7a4d36224(forced) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(istrue(self.insertingarmorplate) || self isswitchingweapon()) {
    return;
  }

  function_b68eee405219319d(1);
  applyarmorcancelplayercommands();
  function_eacc3cc208bb6654(1);
  self.armor.var_a23c324fc96117fe = self getcurrentweapon();
  armorweaponobj = function_9a088885bdb90ef6();
  armorweaponoffhandobj = function_16ca171339b44156();
  var_929b489d6c163415 = isDefined(armorweaponobj);
  weaponchanged = 0;
  var_93addfdd4583a3c5 = 0;
  usetime = 1.2;
  partialtime = 1;
  finishtime = 0.14;

  if(isDefined(armorweaponoffhandobj) && istrue(self.armor.useoffhand)) {
    var_929b489d6c163415 = 0;
  }

  if(var_929b489d6c163415) {
    if(getdvarint(@ "hash_d8e69627073e0766")) {
      iprintln("y\x9f\xb4\xa1\a^#\xfa_\x83\xe5\xff\x16\xb1^+\xaa");
    }

    if(1 || !function_c525c145a5f1d90f()) {
      self giveweapon(armorweaponobj);
    } else {
      self giveweapon(armorweaponobj, 0, 0, 0, 1);
      var_93addfdd4583a3c5 = 1;
    }

    self switchtoweapon(armorweaponobj);
    weaponchanged = function_d4dcc198e32c819f();
  } else if(isDefined(armorweaponoffhandobj)) {
    usetime = 0.9;
    finishtime = 0.105;
    val::set("\xbd*@\xe5\x189\xe5\xf0\xcb\xc1\x1b1\x02", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 1);
    self giveandfireoffhand(armorweaponoffhandobj);
    weaponchanged = 1;
  }

  if(weaponchanged) {
    thread watchcancelnotifies();
    insertarmor(var_93addfdd4583a3c5, forced, usetime, partialtime, finishtime);
  } else if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("\x0e<6T\xde\xfe\xa9\x06\x11\xf6\x96g\b;\xa0\xfc\xee\xd0p\x03@\xe5k\xf1|\x02u");
  }

  armor_cleanup();
}

function function_d4dcc198e32c819f() {
  outcome = utility::waittill_any_return("fUN\xb4\x89z\x9b\xd3\xb4\xa9x\xd6", "\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4", "\x94\x1b\x1f\xcbF\xb5`\x1d\xd8\xfd\xbd\xa6\xa0\xb3\xd24", "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  return outcome == "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY";
}

function private watchcancelnotifies() {
  self endon("\xa4\x8bX\x8a\x1c\xbb\x90\xf1\b-$\x91EB\xa1o\xa7\x1e\x83");
  self.stoparmorinsert = 0;
  outcome = utility::waittill_any_return("\x1e\xfd\xd1\xa2\a", "fUN\xb4\x89z\x9b\xd3\xb4\xa9x\xd6", "\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4", "\x94\x1b\x1f\xcbF\xb5`\x1d\xd8\xfd\xbd\xa6\xa0\xb3\xd24", "c\xdd/\x02NV\xc7e\xee\x10\x9f\x1a\xfa\xffKL");

  if(outcome != "c\xdd/\x02NV\xc7e\xee\x10\x9f\x1a\xfa\xffKL") {
    self.stoparmorinsert = 1;
  }
}

function armor_cleanup() {
  restore_weapon();

  if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("\x94\xcas\x1d\xdb'+\x80;ac\xab\x957\x04\v7\x91 6lV\v\xdc\xd5p\bi\x04#RNIS\x90\x8a\"$");
  }

  function_2f0862a0db00a504();
  function_eacc3cc208bb6654(0);
  self.stoparmorinsert = 0;
  val::reset_all("\xbd*@\xe5\x189\xe5\xf0\xcb\xc1\x1b1\x02");
  self notify("\xa4\x8bX\x8a\x1c\xbb\x90\xf1\b-$\x91EB\xa1o\xa7\x1e\x83");
  function_b68eee405219319d(0);
  self.armor.buttonpresscount = 0;
}

function restore_weapon() {
  if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("+\x03l\x9diB\x99W\xf1\x80\xab\xb6\xbc5H \x15");
  }

  weapon = function_9a088885bdb90ef6();

  if(isDefined(weapon)) {
    self takeweapon(weapon);
  }

  offhand = function_16ca171339b44156();

  if(isDefined(offhand)) {
    self takeweapon(offhand);
  }

  self switchtoweapon(self.armor.var_a23c324fc96117fe);
  self disableweaponswitch();

  for(i = 0; i < 5; i++) {
    if(self getcurrentweapon() == self.armor.var_a23c324fc96117fe) {
      break;
    }

    waitframe();

    if(getdvarint(@ "hash_d8e69627073e0766")) {
      iprintln("\xa1jH\xa5\xa9kr|\xe0\x19\xbb\xcc\xd0`K\x96K'\xeb\xc4\x14\x9dD!;");
    }
  }

  if(self getcurrentweapon() != self.armor.var_a23c324fc96117fe) {
    if(getdvarint(@ "hash_d8e69627073e0766")) {
      iprintln("\xfc\xd9\xbcB\xe9?\xf2\xdb\x02\xa3\x9cNGuo\x98\xa5\x80n\x1e\x95\xbc\xdc~~\x9f=\x02\xf0\xeb#\xb3\x18\x1c");
    }

    self switchtoweaponimmediate(self.armor.var_a23c324fc96117fe);
    waitframe();
  }

  self enableweaponswitch();
}

function private function_b6d288653605d48c() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self waittill("\x94\x95\xf0\x1f1\xac\x85l<M\x82\xa1\xfc\xf9\xedP\t\xfd\xf0\xde\xf8\xca\x05\xbc4");
  loot::function_5a473b51b0aa77d1("\x8b}\xd3\x06\x1c\xa64_", &armorboxloot, &function_4aa0c3afbdebfcc3, &function_156565574e9d5dd9);
}

function private armorboxloot(name) {
  level.player function_64ebd7c2636ec6dd();
}

function private function_4aa0c3afbdebfcc3(name) {
  return level.player function_b77a5b6ee26de43() >= level.player function_9828b76d9dcaef2d();
}

function private function_156565574e9d5dd9(name, displayname) {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.cursor_hint_ent endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    inactive = function_4aa0c3afbdebfcc3(name);
    self.cursor_hint_ent sethintinoperable(inactive);
    waitframe();
  }
}

function private insertarmor(var_856845cbd17fb7f4, forced, usetime = 1.2, partialtime = 1, finishtime = 0.14) {
  if(!istrue(forced) && (!caninsertarmor() || istrue(self.stoparmorinsert))) {
    return;
  }

  var_4221850add10bd2 = usetime;

  if(var_856845cbd17fb7f4) {
    var_4221850add10bd2 += partialtime;
  }

  function_19f02a72232104f3(var_4221850add10bd2, finishtime);
  waittillframeend();

  while(!self.stoparmorinsert && function_6d9c2fd78680ecf0()) {
    function_19f02a72232104f3(var_4221850add10bd2);
    waittillframeend();
  }

  self notify("c\xdd/\x02NV\xc7e\xee\x10\x9f\x1a\xfa\xffKL");
}

function private function_6d9c2fd78680ecf0() {
  if(!caninsertarmor()) {
    return 0;
  }

  usetype = armorplateusetype();

  switch (usetype) {
    case 2:
      return 1;
    case 1:
      gamepad = utility::is_player_gamepad_enabled();
      isholdinggamepad = self weaponswitchbuttonPressed();
      isholdingkbm = !istrue(self.armor.buttonreleased);
      isholding = isholdinggamepad && gamepad || isholdingkbm && !gamepad;
      return isholding;
    case 0:
      return (self.armor.buttonpresscount > 0);
    default:
      return 0;
  }
}

function function_19f02a72232104f3(var_4221850add10bd2, finishtime = 0.14) {
  if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("<dev string:x2af>");
  }

  if(istrue(function_c6dc153e21f6de0b(var_4221850add10bd2))) {
    function_ae8d8e5fe2075d2a();
    wait finishtime;
    return;
  }

  if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("<dev string:x2c2>");
  }
}

function function_c6dc153e21f6de0b(var_4221850add10bd2 = 1.2) {
  self endon("fUN\xb4\x89z\x9b\xd3\xb4\xa9x\xd6");
  self endon("\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4");
  self endon("\x94\x1b\x1f\xcbF\xb5`\x1d\xd8\xfd\xbd\xa6\xa0\xb3\xd24");
  wait var_4221850add10bd2;
  return true;
}

function function_ae8d8e5fe2075d2a() {
  if(istrue(self.stoparmorinsert)) {
    return;
  }

  setarmorplateamount(function_b77a5b6ee26de43() - 1);
  function_dd826d8f1938aeda();

  if(istrue(level.loot.var_7d19d42036e22ee3) && val::get("\x1a\x9c\xb3\x11\xb5\xe0[6\xd6{8\x84")) {
    set_normalhealth(1);
  }

  self.hadarmor = 1;
  self.armor.buttonpresscount = (self.armor.buttonpresscount ?? 1) - 1;

  if(getdvarint(@ "hash_d8e69627073e0766")) {
    iprintln("<dev string:x2db>");
    iprintln("<dev string:x299>" + self.armor.buttonpresscount);
  }

  self notify("\x85'[{9_\xe0\xd8a\xa3\xac\xeb\xa5\xb9\xe6\xac\x9ct\xb2\x8c");
}

function private function_eacc3cc208bb6654(isusingarmor) {
  if(isusingarmor) {
    val::set("\xf7~{\xb1\x14", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
    val::set("\xf7~{\xb1\x14", "\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X", 0);
    val::set("\xf7~{\xb1\x14", "\x9a\xe3\xe4\xff\x81%", 0);
    val::set("\xf7~{\xb1\x14", "mV\x8d+e", 0);
    val::set("\xf7~{\xb1\x14", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    val::set("\xf7~{\xb1\x14", "\xb7\xb3\x06\x15@\xf8\xeen\xaadW\xffN\xf3\xd5\xbe=", 0);
    val::set("\xf7~{\xb1\x14", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    val::set("\xf7~{\xb1\x14", "\x86X7\x8c\xdc", 0);

    if(!function_421fb62426747763() || istrue(self.armor.alwaysdisableuse)) {
      val::set("\xf7~{\xb1\x14", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
    }
  } else {
    val::reset_all("\xf7~{\xb1\x14");
  }

  self.insertingarmorplate = isusingarmor;
}

function private applyarmorcancelplayercommands() {
  if(function_421fb62426747763()) {
    thread applyarmorcancelplayercommandsthread();
  }
}

function private applyarmorcancelplayercommandsthread() {
  self notify("\xb0$3\x88T\xb0\xb1\x8b>\xb81Bo\xac'\xbb");
  self endon("\xb0$3\x88T\xb0\xb1\x8b>\xb81Bo\xac'\xbb");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xb0\x1cp\x1b\xe5\x05\xc9[o\xc9h\xb0\xb9\x8de6\xa0c\xb0\x97Y\x9c\xd0{\xad\xda\x167\xc8\xdc\x15\r'\xb2\x16\x8c");
  utility::waittill_any("3\xf4\xbfq\xca\x04~L|\x8el\xbc3\x81ts\xd4\xec\xac\xf2\xc3", "\x86\xad\xfb\xd6\xcba@l*$\xd1\xfaO:", "7kome\xf5\x0eNes\xdcY\x19", "\xc8e\xa0\x86!6>\xf5\xc61\x84H", "\x05HX\f\x05\xd4\xc50\xa6Dtt\v");
  self notify("\x94\x1b\x1f\xcbF\xb5`\x1d\xd8\xfd\xbd\xa6\xa0\xb3\xd24");
}

function private function_2f0862a0db00a504() {
  self notify("\xb0\x1cp\x1b\xe5\x05\xc9[o\xc9h\xb0\xb9\x8de6\xa0c\xb0\x97Y\x9c\xd0{\xad\xda\x167\xc8\xdc\x15\r'\xb2\x16\x8c");
}

function healthratio() {
  return self.health / self.maxhealth;
}

function firedamageratio() {
  return self.damage.firedamage / 100;
}

function healthratioinverse() {
  return 1 - healthratio();
}

function hasmaxhealth() {
  return self.health == self.maxhealth;
}

function damageratio(damage) {
  return math::normalize_value(40, 160, damage / self.damagemultiplier);
}

function belowcriticalhealththreshold() {
  return self.health < criticalhealththreshold();
}

function criticalhealththreshold() {
  return self.maxhealth * self.var_34a1298708ca48f0;
}

function function_2ebfa5470e27d5e6() {
  return utility::damageflag(2);
}

function initarmor() {
  if(utility::playerarmorenabled()) {
    if(function_6bb509b1062b99ae()) {
      setsaveddvar(@ "bg_piggybackarmoronnvg", 1);
    }

    utility_sp::add_hint_string("v\x1e~\"\v\xf8\x1f\x17!_\x90", &"shared_hintstrings/armor_plates_full");
    setdvarifuninitialized(@ "hash_d8e69627073e0766", 0);
    self.armor = spawnStruct();
    self.armor.sfx = utility::spawn_script_origin();
    self.armor.sfx linkTo(self);
    self.armor.plates = 0;
    self.armor.maxplates = 3;
    self.armor.amount = 0;
    self.armor.maxamount = 33.3333;
    self.armor.everhadarmor = 0;
    self.armor.toggleuifunc = &armortoggleui;
    self.armor.alwaysdisableuse = undefined;
    self.armor.var_af2c34273f285356 = undefined;
    self.armor.maxamountbonus = undefined;
    function_b68eee405219319d(0);

    if(isDefined(level.gamemodebundle.campaignlootlist)) {
      lootlist = getscriptbundle("\x87eX\xbaayH\xa4h~{\xf4mk9\x16\xf8" + level.gamemodebundle.campaignlootlist);
      var_8fb6dda70ff2f338 = lootlist.maxplates;
      defaultmaxarmor = lootlist.maxarmor;
      self.armor.alwaysdisableuse = lootlist.var_fcd0e1e606abf3a7;
    }

    self.armor.maxplates = var_8fb6dda70ff2f338 ?? 3;
    self.armor.maxamount = defaultmaxarmor ?? 100;
    setarmormaxamount(level.player.armor.maxamount);

    if(isDefined(level.gamemodebundle.armormetadata)) {
      var_6abee08a81caf3f0 = getscriptbundlefieldvalue(level.gamemodebundle.armormetadata, #"hash_d2afe427271bb0fd");
    }

    var_177271faf96ae52f = undefined;

    if(isDefined(level.mapbundle.startingarmorplates)) {}

    if(isDefined(var_6abee08a81caf3f0) || isDefined(var_177271faf96ae52f)) {
      startingplates = var_177271faf96ae52f ?? var_6abee08a81caf3f0;
      function_38272a9887d2838(startingplates);
    }

    function_a11494e8ab9840d1();
    thread usearmorplateinput();
    armortoggleui();
    thread function_45f2ee8f914fbfa();
    return;
  }

  armornoui();
}

function private function_45f2ee8f914fbfa() {
  self notify("\x93\x9cs& 3\x8cF\xb0'\f\x99\x19\x8dj\xe4\xcc");
  self endon("\x93\x9cs& 3\x8cF\xb0'\f\x99\x19\x8dj\xe4\xcc");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(utility::playerarmorenabled()) {
    wait 0.25;

    if(function_a9817b6e19b16060()) {
      self setclientomnvar("\xf8xAhz\r@\xa6\xe4\x1d\x12\xbe8", "|\x05.\xa3\x91\x10\xbe\xe5\x91");
      continue;
    }

    self setclientomnvar("\xf8xAhz\r@\xa6\xe4\x1d\x12\xbe8", "\xa3{s\x88\x9c*\x01\xcf\x97\x10");
  }
}

function function_a11494e8ab9840d1() {
  if(utility::playerarmorenabled()) {
    if(function_6c79ce92cc1eda2a()) {
      self.armor.amount = getarmormaxamount();
    }

    thread updatearmorui();
  }
}

function function_6c79ce92cc1eda2a() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.startfullarmor)) {
    return true;
  }

  return false;
}

function function_6bb509b1062b99ae() {
  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_ac005047e3e5b148)) {
    return true;
  }

  if(isDefined(level.mapbundle) && istrue(level.mapbundle.var_ac005047e3e5b148)) {
    return true;
  }

  return false;
}

function hasarmor() {
  return getdvarint(@ "hash_bfa6bedc37206c58") && getarmoramount();
}

function getarmoramount() {
  return self.armor.amount;
}

function getarmormaxamount() {
  return self.armor.maxamount + (self.armor.maxamountbonus ?? 0);
}

function function_1ce6325d5bcc22a1(newarmoramount) {
  if(!isDefined(newarmoramount) || newarmoramount == 0) {
    level.player setarmormaxamount(33);
    return;
  }

  switch (newarmoramount) {
    case 33:
      level.player setarmormaxamount(66);
      break;
    case 66:
      level.player setarmormaxamount(100);
      break;
    default:
      assertmsg("<dev string:x2f3>");
      break;
  }
}

function getarmormaxamountever() {
  return 100;
}

function function_e3627d4ae9fe9a89() {
  return self.armor.platearmoramount ?? 33.3333;
}

function setarmormaxamount(amount) {
  self.armor.maxamount = amount;
  sethadarmor();
  thread updatearmorui();
}

function setarmoramount(amount) {
  self.armor.amount = clamp(amount, 0, getarmormaxamount());
  sethadarmor();
  updatedamagemultiplier();
  thread updatearmorui();
  updatedamageindicatortype();
  updateviewkickscale();
}

function function_dd826d8f1938aeda() {
  plateamount = function_e3627d4ae9fe9a89();
  armormaxamount = getarmormaxamount();
  currentamount = getarmoramount();
  newamount = currentamount;

  if(plateamount > 33.3333) {
    newamount = currentamount + plateamount;
  } else {
    var_ff39dd6fe443f3a8 = round(0.15 * plateamount);
    var_905b8d1baa756e09 = currentamount + var_ff39dd6fe443f3a8;

    if(var_905b8d1baa756e09 < plateamount) {
      newamount = plateamount;
    } else if(var_905b8d1baa756e09 < plateamount * 2) {
      newamount = plateamount * 2;
    } else {
      newamount = armormaxamount;
    }
  }

  newamount = clamp(newamount, 0, armormaxamount);
  setarmoramount(newamount);
}

function function_3c11e6ce13f4a5f2() {
  armormaxamount = getarmormaxamount();
  setarmoramount(armormaxamount);
}

function function_c525c145a5f1d90f() {
  armormaxamount = getarmormaxamount();
  currentamount = getarmoramount();

  if(currentamount == 0 || currentamount == armormaxamount / 3 || currentamount == armormaxamount / 3 * 2 || currentamount == armormaxamount) {
    return false;
  }

  return true;
}

function haslowarmor() {
  return getarmoramount() <= lowarmorthreshold();
}

function lowarmorthreshold() {
  return getarmormaxamount() * 0.25;
}

function hasmaxarmor() {
  return getarmoramount() >= getarmormaxamount();
}

function function_6e8ed8adbf3f8987() {
  return getarmoramount() >= getarmormaxamountever();
}

function armorratio() {
  if(getarmormaxamount() > 0) {
    return (getarmoramount() / getarmormaxamountever());
  }

  return 0;
}

function armorratioinverse() {
  return 1 - armorratio();
}

function function_b77a5b6ee26de43() {
  return int(self.armor.plates);
}

function function_421fb62426747763() {
  return function_9828b76d9dcaef2d() > 0;
}

function setarmorplateamount(amount) {
  self.armor.plates = int(clamp(amount, 0, function_9828b76d9dcaef2d()));
  sethadarmor();
  thread updatearmorui();
}

function function_64ebd7c2636ec6dd() {
  setarmorplateamount(function_9828b76d9dcaef2d());
}

function sethadarmor() {
  if(self.armor.everhadarmor) {
    return;
  }

  if(self.armor.plates > 0 && function_1d86c408ed27cec2() || self.armor.amount > 0) {
    self.armor.everhadarmor = 1;
    armortoggleui();
  }
}

function armortoggleui(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value && self.armor.everhadarmor && val::get("\xf7~{\xb1\x14") && getdvarint(@ "hash_bfa6bedc37206c58")) {
    setomnvar("\x1aK\xe2I\x1b\xf4\xcf\x8a~R\xca\xa9\xc8", 1);
    return;
  }

  setomnvar("\x1aK\xe2I\x1b\xf4\xcf\x8a~R\xca\xa9\xc8", 0);
  level.player notify("\x94\x1b\x1f\xcbF\xb5`\x1d\xd8\xfd\xbd\xa6\xa0\xb3\xd24");
}

function armornoui() {
  setomnvar("\x1aK\xe2I\x1b\xf4\xcf\x8a~R\xca\xa9\xc8", 0);
}

function function_9828b76d9dcaef2d() {
  return int(self.armor.maxplates + (self.armor.var_af2c34273f285356 ?? 0));
}

function hasmaxarmorplates() {
  return function_b77a5b6ee26de43() == function_9828b76d9dcaef2d();
}

function function_353ed6b2f05010c9(amount) {
  self.armor.maxplates = amount;
}

function usingarmorplate() {
  return self.armor.usingplate;
}

function function_b68eee405219319d(boolean) {
  self.armor.usingplate = boolean;
}

function updatedamageindicatortype() {
  if(!hasarmor()) {
    setsaveddvar(@ "hash_f64594b71057fdac", 0);
    return;
  }

  setsaveddvar(@ "hash_f64594b71057fdac", 1);
}

function updatedamagemultiplier() {
  if(hasarmor()) {
    self.damagemultiplier = self.gs.damagemultiplierarmor;
    return;
  }

  self.damagemultiplier = self.gs.damagemultiplierhealth * self.gs.scripteddamagemultiplier * self.gs.basehealthdamagemultiplier;
}

function updateviewkickscale() {
  scale = function_f6565d441b2fb816(self.currentweapon);
  scale *= self.gs.flinchmultiplier;
  scale *= level.var_950679a3379371d0 ?? 1;

  if(hasarmor()) {
    self setviewkickscale(scale + 0.7);
    return;
  }

  self setviewkickscale(scale);
}

function function_f6565d441b2fb816(weapon) {
  scale = undefined;
  flinchtype = weapongetflinchtype(weapon);

  if(flinchtype == 4) {
    scale = 0.2;
  } else if(flinchtype == 3) {
    scale = 0.08;
  } else if(flinchtype == 1) {
    scale = 0.1;
  } else {
    scale = 0.05;
  }

  return scale;
}

function weapongetflinchtype(weaponobj) {
  class = "\r+x5";
  flinchtype = -1;

  if(isDefined(weaponobj) && !isnullweapon(weaponobj)) {
    class = weaponclass(weaponobj.basename);

    switch (class) {
      case #"hash_719417cb1de832b6":
        flinchtype = 1;
        break;
      case #"hash_6191aaef9f922f96":
        if(weaponobj.basename == "\x8e`0\xbf\x1f\xc6`\x0fS\x8d/\a\xa8" || weaponobj.basename == "\x7fAh\xfbb\xaf WN\xfd\a\x14\r\x9dD" || weaponobj.basename == "W\xba,\xec~\xb5\a\x82\x82C\x96t" || weaponobj.basename == "`\xfb\x01\xcb\xdfF\xffO\x06W\xba\x02\xb7\xea\x7f") {
          flinchtype = 3;
        } else {
          flinchtype = 4;
        }

        break;
      default:
        flinchtype = 0;
        break;
    }
  }

  return flinchtype;
}

function set_normalhealth(normalamount) {
  self setnormalhealth(normalamount);
  self.lasthealth = self.health;
}

function disable_player_weapon_info() {
  setDvar(@ "hash_c815d5683eea5b67", 1);
  setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 1);
}

function allow_player_weapon_info(shownow) {
  setDvar(@ "hash_c815d5683eea5b67", 0);

  if(isDefined(shownow) && shownow) {
    show_hud_listener_logic();
  }
}

function hud_think() {
  thread button_notifies();
  thread hide_hud_on_death();
  thread hud_visibility_timer();
  thread show_hud_listener();
  thread function_494c968a5650b15a();
}

function show_hud_listener() {
  self endon("\x1e\xfd\xd1\xa2\a");
  event_notifies = ["9\xfca\xad\f^Rj.\xe6\xc6$", "\xb5\x10\xb9", "9Yl\xdb\x85\x91}\x1cr\x95n\xb9\x95\x91", "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", "W\x89/9}-\xa4.\xa0\x1e\xa4", "\x1a\x962\xca\xf5\x86]F_\xed[sv,\x9c\xeb6h,n\xb3\xac2", "\xc8e\xa0\x86!6>\xf5\xc61\x84H", "7kome\xf5\x0eNes\xdcY\x19", "\xdc3\x94\v\xbd^\x98[\x18\xd9}\x88S\x1a\x81\xda", "hc*0A\xe5W\xee\xe1\x91\xe5\x01\xa4:kVh_\xa5\xa9", "\x12\x1e\x86V\x91\xd8\x81l\x9d`\x1c\x82", "(\xf8\xe0\xaa=\xdcyT\xbf", "L\xf3NF\x8a{\xcf\xa3^", "?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "\x0e\x8f(A>'\x17=0\nw", "\fU`\xc0y\x95", "C${\x7f\x7fw\xf8\xd9\x98!:s", "}x\x84\xde\xa8\xae\a\v#\xe6\xab o", "v=D.\xe0\xaeb\xe5KU\xe3\xee\x86"];

  while(true) {
    waittill_hud_event_notify(event_notifies);

    if(!utility_sp::in_realism_mode()) {
      show_hud_listener_logic();
    }
  }
}

function function_494c968a5650b15a() {
  self endon("\x1e\xfd\xd1\xa2\a");
  var_bbee2fe55064cb28 = ["\xa2\xfb+A\x86&\xef\x13tc\xe9$", "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", "\xc8e\xa0\x86!6>\xf5\xc61\x84H", "7kome\xf5\x0eNes\xdcY\x19"];

  while(true) {
    waittill_hud_event_notify(var_bbee2fe55064cb28);

    if(utility_sp::in_realism_mode()) {
      show_hud_listener_logic(1);
    }
  }
}

function waittill_hud_event_notify(event_notifies) {
  foreach(note in event_notifies) {
    self endon(note);
  }

  self waittill(")\xb0\x16\xd5YF\xae");
}

function show_hud_listener_logic(showinrealism) {
  if(utility_sp::in_realism_mode() && !istrue(showinrealism)) {
    return;
  }

  player_demeanor = utility_sp::get_player_demeanor();
  var_27ad3c669f4b53b0 = val::get("7\x86\xed\xee\xfa\xee\xacXp{n\xbe\xa1\xae\x91");

  if(player_demeanor != " w%\xe0" && !getdvarint(@ "hash_c815d5683eea5b67") && var_27ad3c669f4b53b0) {
    setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 0);
  }

  self notify("\x96?\x18Q\xf7|\xdb\xda\xdc@\xfa\xbc\x81\xf8+");
  wait 1;
  thread hud_visibility_timer();
}

function private is_in_combat() {
  enemies = getaiarrayinradius(self.origin, 3600, utility::get_enemy_team(self.team));

  foreach(nearbyai in enemies) {
    if(isalive(nearbyai) && gettime() - nearbyai lastknowntime(self) < 10000) {
      return true;
    }
  }

  return false;
}

function private function_932ae6e5b9f9d72d() {
  return self getlocalplayerprofiledata("\x86\xaa1\x89\x97\xde\x1a\x0e\xe6\xec\xd1\x83\xe1c\xae]\xe3^. \xb8E\xfe\xce\x19\xee") > 0 || utility::damageflag(2) || utility::damageflag(1) || is_in_combat() || self.health < self.maxhealth && canregenhealth();
}

function hud_visibility_timer() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x96?\x18Q\xf7|\xdb\xda\xdc@\xfa\xbc\x81\xf8+");

  if(utility_sp::in_realism_mode()) {
    wait 2;
  } else {
    wait 5;

    while(function_932ae6e5b9f9d72d()) {
      wait 1;
    }
  }

  setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 1);
  childthread hud_omnvar_change_listener();
}

function hud_omnvar_change_listener() {
  var_45057d716816516b = getomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc");
  var_2e4185f34efdc0b3 = getomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef");

  while(getomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc") == var_45057d716816516b && getomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef") == var_2e4185f34efdc0b3 && self getlocalplayerprofiledata("\x86\xaa1\x89\x97\xde\x1a\x0e\xe6\xec\xd1\x83\xe1c\xae]\xe3^. \xb8E\xfe\xce\x19\xee") == 0) {
    waitframe();
  }

  self notify("\x1a\x962\xca\xf5\x86]F_\xed[sv,\x9c\xeb6h,n\xb3\xac2");
}

function button_notifies() {
  self endon("\x1e\xfd\xd1\xa2\a");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "T\x8c\xa2\xf1\xc1\xbf\x9d1\x89\xf4\xc9;\xec");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "\x13KI\xd7\x9b\xd1\xabpnj]+\xe1");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "F\x8c\xae\xa5bx*'\xed#y\x9cn");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "\x11\xac !5B5kw\xb5b");
  level.player notifyonplayercommand("?\xa7\b\xbft\x04.b\xe0.\xd9kB\xc2RN\xd16u\xe2\"\xee\x16", "cc'\x93{\x1d.X\xdf");

  while(true) {
    if(self adsButtonPressed()) {
      self notify("\xb5\x10\xb9");
    }

    if(self meleeButtonPressed()) {
      self notify("mV\x8d+e");
    }

    waitframe();
  }
}

function hide_hud_on_death() {
  self waittill("\x1e\xfd\xd1\xa2\a");
  setomnvar("\xfb\nX{\x88\b\x89\x9cV~m\xefg\xe8g\xfc-\xfc\xef", 1);
}

function function_7584030181ac6dd5(enabled) {
  setomnvar("\x1e\x16\x1e\xf8\x8b\xc2\xb2Km\x04E\xd1\xd3H\xcf|\xd7\xb1&\xf4\x9b\x88\x93x\x7f", enabled);
}

function function_7b7866956f048eb4(enabled) {
  setomnvar("\xcfX\xefs\x80bZ\xc1/\xe6\x1b\x99\xab?s\xdb\x19ct\x81\xea?@+\xf0\"\xa12", enabled);
}

function function_8bed60f5892b1ed8(enabled) {
  setomnvar("]\xd2\xf5n4\xdew_X\x9cm\xb7r_\r\xb2a6\xa3C\xbe\x99{\xc9ce", enabled);
}

function playerfocusmain() {
  self endon("\x1e\xfd\xd1\xa2\a");
  setsaveddvar(@ "r_hudoutlineoccludedcolorfromfill", 1);
  childthread focusmonitor();
}

function focusmonitor() {
  thread focusmonitorrelease();

  while(true) {
    situation = utility::waittill_any_ents_return(self, "3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#", level, "\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc", level, "\xbbe\xe1D\x17\x96\b\xd0R\xb4\xe1\xbb\x8d\xab\x84\xb3\xd7\x8e\x92\x89\f\xfb\xae\x17\v\x90");

    if(situation == "3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#" && focusallowed()) {
      self.focus.buttonhelddown = 1;
      thread analytics::update_focus_counter();

      if(!self.focus.usedonce) {
        self.focus.usedonce = 1;
      }

      thread focusactivate();
      focusrelease_waittill();
      self.focus.buttonhelddown = 0;

      if(focusallowed() && self getclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=")) {
        var_17b048ca91f1feab = gettime() + self.focus.minholdtime * 1000;

        while(focusallowed() && gettime() < var_17b048ca91f1feab && self getclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=")) {
          waitframe();
        }

        function_1d779b28d47da31f();
      }

      thread focusdeactivate();
      continue;
    }

    if(situation == "\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc") {
      if(focus_objectives_update_display()) {
        setsaveddvar(@ "objectivealpha", self.focus.maxalpha);
        setomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 1);
        thread focustimeadjust();

        for(endtime = getfocusendtime(); gettime() < endtime; endtime = getfocusendtime()) {
          wait 0.1;

          if(self.focus.timeadjust) {
            self.focus.timeadjust = 0;
          }
        }

        self notify("\xa3\xe3\x10Br-\xb6m\xe8\xb9\x893W\x90\x95>\xb0\x96P\xd4\xf9pr");

        while(focus_infinite_hold()) {
          waitframe();
        }

        function_1d779b28d47da31f();
        thread focusdeactivate();
      }

      continue;
    }

    if(situation == "\xbbe\xe1D\x17\x96\b\xd0R\xb4\xe1\xbb\x8d\xab\x84\xb3\xd7\x8e\x92\x89\f\xfb\xae\x17\v\x90") {
      setomnvar("\xd5i\xd7o\x13\x9a+6ti\xecV\x9b\xf5\xd5\x1c\x91\v\xe8+F\xaf\xdco\xbe\xc1\xb4\xcdv", 1);
      waitframe();
      setomnvar("\xd5i\xd7o\x13\x9a+6ti\xecV\x9b\xf5\xd5\x1c\x91\v\xe8+F\xaf\xdco\xbe\xc1\xb4\xcdv", 0);
    }
  }
}

function focusenable() {
  self.focus.disabled = 0;
  self notify("f\xdb\xb1\xae\xdc\xbe\xac\x9b\v1\x1bY\xc8");
}

function focusdisable() {
  self.focus.disabled = 1;
  self notify("w\xb0\xdcG\xe2X\x04\xbe\xbf\x04\xb4\x8b\xd4\x03");
}

function function_5048f1831d2fa4c0(allow) {
  self.focus.var_70547fa31c4b422e = allow;
}

function focusallowed() {
  return !self.focus.disabled && val::get("\xd56a\x9b\xba$Do]uE\xb6\x9b1") && !val::get(" \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[") && ((self.focus.var_70547fa31c4b422e ?? 0) || !self islinked() || isDefined(self.veh));
}

function focusrelease_waittill() {
  if(self.focus.releasetime != gettime()) {
    self endon(";\\?\xd6\x90:\xc93\xa4\xb1\xd0HW\x95");

    while(focusallowed()) {
      waitframe();
    }
  }
}

function private focusmonitorrelease() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    self waittill(";\\?\xd6\x90:\xc93\xa4\xb1\xd0HW\x95");
    self.focus.releasetime = gettime();
  }
}

function function_9561c3c3ba7e61ee(speed) {
  self.focus.speed = speed;
}

function function_1d779b28d47da31f() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(focusallowed() && self getclientomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=")) {
    cur_speed = 0;

    if(isDefined(self.veh)) {
      cur_speed = utility::mph_to_ips(self.veh vehicle_getspeed());
    } else {
      cur_speed = length(self getvelocity());
    }

    if(self.focus.speed <= cur_speed) {
      break;
    }

    wait 0.25;
  }
}

function getfocusendtime() {
  return gettime() + 5000;
}

function focustimeadjust() {
  self endon("\xa3\xe3\x10Br-\xb6m\xe8\xb9\x893W\x90\x95>\xb0\x96P\xd4\xf9pr");

  while(true) {
    level waittill("1\x92\xbd\xdd\x83{$\xd6\xdcg\xd3\x13>\\Cn(\xa6\xf6\xc1\x1d\xd6\xc0\xae", event);

    if(event != "\x194\xc9\x879\xc7\xbe\xb2\xb6") {
      self.focus.timeadjust = 1;
    }
  }
}

function forcesetamount(amount) {
  self.focus.amount = amount;
}

function forceamount() {
  return self.focus.amount;
}

function focusactivate() {
  currentalpha = getdvarfloat(@ "objectivealpha");
  var_122ab9e7fc17b1c8 = 1 - math::normalize_value(self.focus.minalpha, self.focus.maxalpha, currentalpha);
  intime = var_122ab9e7fc17b1c8 * self.focus.fadeintime;
  endtime = gettime() + intime * 1000;
  frames = intime * 20;
  var_543e2c142a166acb = math::factor_value(self.focus.maxalpha, self.focus.minalpha, currentalpha);
  alphaslice = var_543e2c142a166acb / frames;
  focushighlightadditionalentsenable();
  setomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 1);

  if(function_6b3ba8e5cd6118cd()) {
    if(istrue(self.focus.markedshown) && function_6e7d1d8db1931013()) {
      function_d9b2cacbe782de5c(0);
    } else {
      self.focus.markedshown = 1;
    }
  }

  while(gettime() < endtime) {
    currentalpha = getdvarfloat(@ "objectivealpha");
    nextalpha = clamp(currentalpha + alphaslice, self.focus.minalpha, self.focus.maxalpha);
    setsaveddvar(@ "objectivealpha", nextalpha);
    forcesetamount(nextalpha);
    forcesethudoutlinealpha(nextalpha);
    waitframe();
  }

  setsaveddvar(@ "objectivealpha", self.focus.maxalpha);
}

function focusdeactivate() {
  self endon("3\xb7\xc6\xab7\xfa\x0e\xe4\xca\x9b7e#");

  if(focus_objectives_update_display()) {
    level endon("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
  }

  currentalpha = getdvarfloat(@ "objectivealpha");
  var_aeab740fb5df34d0 = math::normalize_value(self.focus.minalpha, self.focus.maxalpha, currentalpha);
  outtime = var_aeab740fb5df34d0 * self.focus.fadeouttime;
  endtime = gettime() + outtime * 1000;
  frames = outtime * 20;
  var_2394c3d057382857 = math::factor_value(self.focus.minalpha, self.focus.maxalpha, var_aeab740fb5df34d0);
  alphaslice = frames > 0 ? var_2394c3d057382857 / frames : var_2394c3d057382857;
  setomnvar("S\xa0Z\xdf\xf6\xdc\xbe\x99\xe0\x06~ >\xaet\x10\xf1=", 0);

  while(gettime() < endtime) {
    currentalpha = getdvarfloat(@ "objectivealpha");
    nextalpha = clamp(currentalpha - alphaslice, self.focus.minalpha, self.focus.maxalpha);
    setsaveddvar(@ "objectivealpha", nextalpha);
    forcesetamount(nextalpha);
    forcesethudoutlinealpha(nextalpha);
    waitframe();
  }

  focushighlightadditionalentsdisable();
  setsaveddvar(@ "objectivealpha", self.focus.minalpha);

  if(function_6e7d1d8db1931013()) {
    function_d9b2cacbe782de5c(0);
  }
}

function focushighlightadditionalentsenable() {
  if(!isDefined(self.focus.additionalents)) {
    return;
  }

  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(ent in self.focus.additionalents) {
    ent hudoutlineenable(">\xcdzW\r-\xcd\x1fL\xa0>:\xd2C\x85t\x17\xf03'#");
  }
}

function focushighlightadditionalentsdisable() {
  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(ent in self.focus.additionalents) {
    ent hudoutlinedisable();
  }
}

function forcesethudoutlinealpha(alpha) {
  setsaveddvar(hashcat(@ "hash_1429c8e20321bbcd", 1), "\\\xa7v'\x8b" + "\xda" + alpha);
}

function getvisionlerprate(outtime) {
  rate = 1 / max(0.01, outtime);
  return clamp(rate, 0, 30);
}

function offhandremove(equipment) {
  hadweapon = 0;

  foreach(offhand in self.offhandinventory) {
    if(offhand.basename == equipment.basename) {
      self takeweapon(offhand);
      hadweapon = 1;
    }
  }

  if(hadweapon) {
    offhandtype = undefined;

    if(offhands::getweaponoffhandtype(equipment) == "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e") {
      offhandtype = "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e";
      setclassfunc = &setoffhandprimaryclassfunc;
    } else {
      offhandtype = "\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e";
      setclassfunc = &setoffhandsecondaryclassfunc;
    }

    currentoffhand = self getcurrentoffhand(offhandtype);

    if(isDefined(currentoffhand) && currentoffhand.basename == equipment.basename) {
      self[[setclassfunc]]("\r+x5");
    }

    loot::removeoffhandloot(equipment);
  }
}

function offhandswap(equipment, var_b35b4d8a1ef2ed84, additional_attachments) {
  weapon = undefined;
  attachments = [];

  if(!isDefined(additional_attachments)) {
    additional_attachments = [];
  }

  if(isarray(equipment)) {
    foreach(item in equipment) {
      if(i == 0) {
        weapon = item;
        attachments = utility::array_combine(attachments, getweapondefaultattachments(weapon));
        continue;
      }

      attachments[attachments.size] = item;
    }
  } else {
    weapon = equipment;
    attachments = getweapondefaultattachments(weapon);
  }

  if(weapon == "\r+x5") {
    assertmsg("<dev string:x334>");
  }

  if(!offhands::offhandisprecached(weapon)) {
    assertmsg("<dev string:x374>" + weapon + "<dev string:x381>");
  }

  if(offhands::getweaponoffhandtype(weapon) == "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e") {
    var_2c5ae4e03e968c22 = "\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e";
    setclassfunc = &setoffhandprimaryclassfunc;
  } else {
    var_2c5ae4e03e968c22 = "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e";
    setclassfunc = &setoffhandsecondaryclassfunc;
  }

  var_90fce66f3eff48a6 = self getcurrentoffhand(var_2c5ae4e03e968c22);

  foreach(offhand in self.offhandinventory) {
    if(offhand.basename != var_90fce66f3eff48a6.basename) {
      self takeweapon(offhand);
    }
  }

  class = offhands::getweaponoffhandclass(weapon);
  self[[setclassfunc]](class);

  if(isstring(weapon)) {
    weapon = makeweapon(weapon);
  }

  if(istrue(attachments.size)) {
    foreach(attachment in attachments) {
      weapon = weapon withattachment(attachment);
    }
  }

  if(istrue(additional_attachments.size)) {
    foreach(attachment in additional_attachments) {
      weapon = weapon withattachment(attachment);
    }
  }

  self giveweapon(weapon);

  if(isDefined(var_b35b4d8a1ef2ed84)) {
    foreach(offhand in self.offhandinventory) {
      if(offhand.basename != var_90fce66f3eff48a6.basename) {
        self setweaponammoclip(offhand, var_b35b4d8a1ef2ed84);
      }
    }
  }

  loot::setoffhandloot(weapon);
}

function setoffhandsecondaryclassfunc(class) {
  self setoffhandsecondaryclass(class);
}

function setoffhandprimaryclassfunc(class) {
  self setoffhandprimaryclass(class);
}

function dodamagefilter(health, type) {
  if(isDefined(type) && isexplosivedamage(type)) {
    health = int(health * 1 / self.damagemultiplier);
  }

  return health;
}

function player_cinematic_motion_override(cinematicmotionoverride) {
  level.player.cinematicmotionoverride = cinematicmotionoverride;

  if(level.player val::get("{.\xcb\x03\x87\xa8\xceU\x16gx\x86y\xf7\x19\xda")) {
    if(isDefined(level.player.cinematicmotionoverride)) {
      level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
      return;
    }

    level.player clearcinematicmotionoverride();
  }
}

function set_player_ignore_random_bullet_damage(bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  level.player.scriptedignorerandombulletdamage = bool;
  level.player gameskill::update_player_attacker_accuracy();
}

function player_movement_state(state) {
  if(!isDefined(state)) {
    state = "\x91\xca\xcc\v\xab\xd8:";
  }

  suitinfo = get_suit(state);
  movespeed = 150;
  jogenabled = 1;
  level.player.movementstate = state;

  if(isDefined(suitinfo.suit)) {
    level.player setsuit(suitinfo.suit);
    movespeed = suitinfo.speed ?? 150;
    jogenabled = istrue(suitinfo.jog);
  } else {
    level.player setsuit(function_228562272b598116());
  }

  level.player val::reset_all("a\xa9\xb1\x166\xbc\xd0\x8d\xf6\xd3\x9dT\x12\xcc\x99\xf5\xbbi!\"\xdf");

  if(level.player val::get("\xb2w\xbf") && !jogenabled || !level.player val::get("\xb2w\xbf") && jogenabled) {
    if(!jogenabled) {
      level.player val::set("a\xa9\xb1\x166\xbc\xd0\x8d\xf6\xd3\x9dT\x12\xcc\x99\xf5\xbbi!\"\xdf", "\xb2w\xbf", 0);
    }
  }

  utility_sp::player_speed_set(movespeed, 0.5);
}

function function_228562272b598116() {
  if(isDefined(level.gamemodebundle.playerdefaultsuit)) {
    return level.gamemodebundle.playerdefaultsuit;
  }

  suitinfo = get_suit();

  if(isDefined(suitinfo.suit)) {
    return suitinfo.suit;
  }

  return "oK\x9d9\xc1kt+T\xfdw\xb0\x92\xa9";
}

function get_suit(suitstate = "\x91\xca\xcc\v\xab\xd8:") {
  if(!isDefined(level.var_8bdb3f03e8058caa) && isarray(level.gamemodebundle.campaignsuits)) {
    level.var_8bdb3f03e8058caa = [];

    foreach(suit in level.gamemodebundle.campaignsuits) {
      assert(!isDefined(level.var_8bdb3f03e8058caa[suit.state]));
      level.var_8bdb3f03e8058caa[suit.state] = structcopy(suit);
    }
  }

  if(isarray(level.var_8bdb3f03e8058caa)) {
    return level.var_8bdb3f03e8058caa[suitstate];
  }

  return undefined;
}

function function_38272a9887d2838(amount) {
  if(!utility::playerarmorenabled()) {
    return;
  }

  setarmorplateamount(amount);
}

function function_46965df0d3a78e7c() {
  if(!utility::playerarmorenabled()) {
    return;
  }

  return function_b77a5b6ee26de43();
}

function give_player_max_armor() {
  if(!utility::playerarmorenabled()) {
    return;
  }

  setarmoramount(getarmormaxamount());
  self.hadarmor = 1;
}

function remove_all_armor(var_b36891c7424e0777) {
  if(!utility::playerarmorenabled()) {
    return;
  }

  setarmorplateamount(0);
  setarmoramount(0);

  if(istrue(var_b36891c7424e0777)) {
    level.player.armor.maxamount = 0;
    setomnvar("\x1aK\xe2I\x1b\xf4\xcf\x8a~R\xca\xa9\xc8", 0);
    self.armor.everhadarmor = 0;
    level.player updatearmorui();
  }
}

function function_ad9c2ed513b2299a(visionset) {
  self.damage.var_b0db8450cbf46cbb = visionset;
}

function function_aed9d8e7c8f0b30(visionset) {
  self.damage.var_7d4a2ed9ee8b56b5 = visionset;
}

function function_be11005256ee4556(visionset) {
  self.damage.scriptedpainvision = visionset;
}

function function_93b13bbfceab5aff(visionset) {
  self.damage.var_9ed7fdf619e68ea1 = visionset;
}

function function_c95f16e4a14e0d7d(visionset) {
  self.damage.var_de9d9de0c86e326e = visionset;
}

function set_player_max_health(newhealth) {
  self.gs.scripteddamagemultiplier = self.maxhealth / newhealth;
  updatedamagemultiplier();
}

function function_8cba44e5812e8a96() {
  return self.maxhealth / self.gs.scripteddamagemultiplier;
}

function function_f1ed8afbf1bd2509(shader) {
  self.damage.scriptedoverlay = shader;
}

function function_71f38a0e83a29354(shader) {
  self.damage.var_8492fa63b307ff8f = shader;
}

function scale_player_death_shield_duration(scale) {
  if(!isDefined(scale)) {
    scale = 1;
  }

  self.gs.scripteddeathshielddurationscale = scale;
}

function function_4dc820c38c445489(scale) {
  if(!isDefined(scale)) {
    scale = 1;
  }

  self.gs.var_9a45caab4d484b5 = scale;
}

function function_db2292ac8b0798a0(scale) {
  if(!isDefined(scale)) {
    scale = 1;
  }

  self.gs.var_8c2fe6dcd2893a1a = scale;
}

function remove_damage_effects_instantly(var_a92f17817964a5c1) {
  self notify("\x02\xdd\xd8\xf35\xb52\xbe\xe0-\xde\xdd\x8b\x9f\xa0\x8e");

  if(!isDefined(var_a92f17817964a5c1)) {
    var_a92f17817964a5c1 = 0;
  }

  self painvisionoff();

  if(utility::damageflag(2)) {
    disabledeathsdoor(1);
  }

  removefiredamageimmediate();
  removeradialdistortion(0);
  stopimpactsfx();

  if(!var_a92f17817964a5c1) {
    foreach(overlay in self.damage.activescreeneffectoverlays) {
      overlay notify("\f\xdf\x03e\x9c\xbb\xd9+\xbddC*,H\xe8\xbcU\xae\xf6\xcb:\x12\xa6\x84\x1e");
    }
  }

  self.damage.overlay destroy();
  self.damage.bloodoverlay destroy();
  self.damage.deathsdooroverlaypulse destroy();
  initdamageoverlay();
  initbloodoverlay();
  initdeathsdooroverlaypulse();
}

function radial_distortion(distortion, strength, outtime, origin) {
  self notify("\x998\x14\x9fv\xa2\x03\x06\x03k\xac\xa2\x19\xe5%b");
  self endon("\x998\x14\x9fv\xa2\x03\x06\x03k\xac\xa2\x19\xe5%b");
  setsaveddvar(@ "r_mbradialoverridedistortion", distortion);
  setsaveddvar(@ "r_mbradialoverrideradius", -1);
  setsaveddvar(@ "r_mbradialoverridestrength", strength);

  if(isDefined(origin)) {
    setsaveddvar(@ "hash_bc02f8e41595c9a8", 1);
    setsaveddvar(@ "hash_841b904ab274bece", origin);
  }

  if(isDefined(outtime)) {
    removeradialdistortion(outtime);
  }
}

function set_focus_objectives_update_display(boolean) {
  self.focus.objectivesupdatedisplay = boolean;
  level.player setclientomnvar("\xf3\xc0\xf6\x966c\xa3ui\xab::\xfa\xac\xd4\xdf\xf1\xc4\xb4\xb4Bc\xeb]{\xe3_Z\x12\x8a\xc2\xd5\xd9\xf6\xb2", !boolean);
}

function focus_objectives_update_display() {
  return self.focus.objectivesupdatedisplay;
}

function function_d9b2cacbe782de5c(markedonly, var_f305eaf42bad13bf) {
  self.focus.showmarkedonly = markedonly;
  self.focus.var_a665e399e543567d = var_f305eaf42bad13bf;
  self.focus.markedshown = 0;
  self setclientomnvar("\x8b\xd3\xff\xd7\xcaU>\xb0\x1bR\xd6\x99L\xb7\x98\xec\xac\xbe\xbb\xda\xf1\xfb\xd6\xc5,p\x90Q\xcd\xff", markedonly);
}

function function_6b3ba8e5cd6118cd() {
  return istrue(self.focus.showmarkedonly);
}

function function_6e7d1d8db1931013() {
  return istrue(self.focus.var_a665e399e543567d);
}

function set_focus_infinite_hold(boolean) {
  self.focus.infinitehold = boolean;
}

function focus_infinite_hold() {
  return self.focus.infinitehold;
}

function focus_display_hint(delay, timeout, endonentity, endonmessage) {
  utility_sp::display_hint("\xce\x9d\xa1E\xe8P\xdf\x97\ri", timeout, delay, endonentity, endonmessage);
}

function focus_held_down() {
  return level.player.focus.buttonhelddown;
}

function set_player_ladder_weapon(weap) {
  if(!isweapon(weap)) {
    weap = utility_sp::make_weapon(weap);
  }

  self.ladderweapon = weap;
}

function function_7b34d944738943d(var_3155c3e4f1c636cc) {
  thread function_7fe384c001cd6604(var_3155c3e4f1c636cc);
}

function function_7fe384c001cd6604(var_3155c3e4f1c636cc) {
  self notify("?`.\x0eU\xc5\x98\xc1b(\x9fX0\x1e\xd5>#");
  self endon("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.wind = spawnStruct();

  if(!isDefined(self.wind.positioner)) {
    self.wind.positioner = utility::spawn_tag_origin();
  }

  if(!isDefined(self.wind.frontwind)) {
    self.wind.frontwind = utility::spawn_tag_origin();
  }

  if(!isDefined(self.wind.backwind)) {
    self.wind.backwind = utility::spawn_tag_origin();
  }

  self.wind.frontwind linkTo(self.wind.positioner, "\xec\xbfK|\au\xcd\xc2\x19<", (500, 0, 0), (0, 0, 0));
  self.wind.backwind linkTo(self.wind.positioner, "\xec\xbfK|\au\xcd\xc2\x19<", (-500, 0, 0), (0, 0, 0));

  if(!isDefined(var_3155c3e4f1c636cc)) {
    assertmsg("<dev string:x3eb>");
  }

  thread function_20964826165fbcd4();
  self setclientomnvar("\x8f1\f\xec\x94\"\xd3+\r\xd7\xe0e9\xed\xed]VA\xb3", 1);
  self setclientomnvar("\x0f\xa5\v\xbf\a\x14Vz$\xfd\xe8m\xcf\xc6_N\xe9\xde]c", 1);
  thread cycleanim();
  self.nowhizby = 1;
  level.player setcinematicmotionoverride("\xb0u\x82\xc0\x91\xc4\xfb\xeb\xa6\x06\xd10P\xda");

  while(true) {
    if(!isDefined(var_3155c3e4f1c636cc)) {
      break;
    }

    playerang = self getplayerangles();
    eyepos = self getEye();

    if(self.wind.positioner islinked()) {
      self.wind.positioner unlink();
    }

    self.wind.positioner.origin = level.player.origin;

    if(isDefined(var_3155c3e4f1c636cc)) {
      self.wind.positioner.angles = var_3155c3e4f1c636cc.angles;
      self.wind.positioner linkTo(var_3155c3e4f1c636cc);
    }

    playeraxis = anglestoaxis(playerang);
    forwardpos = self.wind.frontwind.origin;
    toforwardvec = vectorNormalize(forwardpos - eyepos);
    toforwarddot = vectordot(toforwardvec, playeraxis["\xa17\xd3\x9fT\x14P"]);
    torightdot = vectordot(toforwardvec, playeraxis["o0\xee\xc1\x8c"]);
    toupdot = vectordot(toforwardvec, playeraxis["\xf3\xf2"]);

    if(toforwarddot > 0) {
      frontloop = 1;
      whizybyent = self.wind.frontwind getentitynumber();
    } else {
      frontloop = 2;
      whizybyent = self.wind.backwind getentitynumber();
    }

    var_c38a45d370e28a67 = abs(toforwarddot);
    var_53fefe45a6a3e639 = 1 - abs(toforwarddot);
    var_2fdeddcaa37db67d = clamp(-1 * toforwarddot, 0, 1);
    var_c13b9457c2572648 = whizby::function_4e68914b3d42d59d(torightdot, toupdot);
    var_c38a45d370e28a67 = math::normalized_float_smooth_out(var_c38a45d370e28a67);
    var_53fefe45a6a3e639 = math::normalized_float_smooth_out(var_53fefe45a6a3e639);
    var_c38a45d370e28a67 = math::factor_value(0, self.wind.intensitycurrent * 0.65, var_c38a45d370e28a67);
    var_53fefe45a6a3e639 = math::factor_value(0, self.wind.intensitycurrent * 0.45, var_53fefe45a6a3e639);
    self setclientomnvar("\xd1\x11\a\xd5\xe9%\x0e^\xbaoyy\\\xd9X\x16\xf0G\x95e\xf4", var_c38a45d370e28a67);
    self setclientomnvar("h%\x80\xf8\xa8zi\xd5d Z\x9c\xff\\'\xca\b%l\xea", var_53fefe45a6a3e639);
    self setclientomnvar("\xff\x18P\xfb\x89\xe7\xb5X{\xa41\x8b\xde cy\x98?\xa9\xde", int(var_c13b9457c2572648));

    if(self getclientomnvar("\xda\xec\xc3s\x8c\x1c\x1aC\x9c\x1a\x7f\xec\x9d") != whizybyent) {
      self setclientomnvar("\xda\xec\xc3s\x8c\x1c\x1aC\x9c\x1a\x7f\xec\x9d", whizybyent);
      self setclientomnvar("\x0f\xa5\v\xbf\a\x14Vz$\xfd\xe8m\xcf\xc6_N\xe9\xde]c", frontloop);
    }

    wait 0.05;
  }

  function_ed000df048a9442a();
}

function cycleanim() {
  self endon("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self setclientomnvar("0\x1b\xe9\xdd|2\xaf\xe40\x98\xc6\xb3\xd6\x87\xdej", gettime());
    wait randomfloatrange(0.15, 0.25);
  }
}

function windquakes() {
  self endon("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(self.wind.intensitycurrent > 0) {
      earthquake(0.1 * self.wind.intensitycurrent, 0.13, self.origin, 2000);
    }

    wait randomfloatrange(0.05, 0.12);
  }
}

function function_ed000df048a9442a() {
  thread function_d73aeadcd5997889();
}

function function_d73aeadcd5997889() {
  self endon("?`.\x0eU\xc5\x98\xc1b(\x9fX0\x1e\xd5>#");
  self endon("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.wind.intensity = 0;
  level.player clearcinematicmotionoverride();

  while(self.wind.intensitycurrent > 0.01) {
    waitframe();
  }

  if(!isDefined(self.wind.positioner)) {
    self.wind.positioner delete();
  }

  if(!isDefined(self.wind.frontwind)) {
    self.wind.frontwind delete();
  }

  if(!isDefined(self.wind.frontwind)) {
    self.wind.backwind delete();
  }

  self setclientomnvar("\x0f\xa5\v\xbf\a\x14Vz$\xfd\xe8m\xcf\xc6_N\xe9\xde]c", 0);
  self setclientomnvar("\x8f1\f\xec\x94\"\xd3+\r\xd7\xe0e9\xed\xed]VA\xb3", 0);
  self setclientomnvar("\xda\xec\xc3s\x8c\x1c\x1aC\x9c\x1a\x7f\xec\x9d", -1);
  self.nowhizby = 0;
  self notify("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
}

function private function_3663892b2bd03aa6(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self.var_b4b6772907565113 = b_value;
}

function private function_1b0a489a18329651(b_value) {
  self.disablepainvision = b_value;

  if(istrue(b_value)) {
    setsaveddvar(@ "hash_e42b132626b5992b", 0);
    self painvisionoff();
  }
}

function function_20964826165fbcd4() {
  self endon("\xca\x7f>jP\xb7\x9a\xf0N\xf9f\x0f\x96\x8f*\x84");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.wind.intensity)) {
    self.wind.intensity = 1;
  }

  if(!isDefined(self.wind.intensitycurrent)) {
    self.wind.intensitycurrent = 0;
  }

  while(true) {
    waitframe();
    self.wind.intensitycurrent += (self.wind.intensity - self.wind.intensitycurrent) * 0.15;
  }
}

function script_getplayersinradius(origin, radius, desiredteam, excludeent) {
  player = level.players[0];

  if(isalive(player)) {
    if(distancesquared(player.origin, origin) <= squared(radius)) {
      if(isDefined(desiredteam)) {
        if(isDefined(player.team) && player.team != desiredteam) {
          return [];
        }
      }

      if(isDefined(excludeent)) {
        if(player == excludeent) {
          return [];
        }
      }

      return [player];
    }
  }

  return [];
}

function getplayerguid(player) {
  return false;
}

function setoperator(operator) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") || getdvarint(@ "g_connectpaths")) {
    return;
  }

  player = self;

  if(!isPlayer(player)) {
    player = level.player;
  }

  profilechoices = player function_fa417f053c6c2c14();

  if(isstring(operator)) {
    player.dbgoperator = operator;
  } else if(isxhashasset(operator)) {
    player.dbgoperator = getsubstr(getxhashsourcename(operator), 13);
  }

  if(isstring(operator)) {
    operator = getscriptbundle("\xc2\xecW\xa1B\xc7\x02\xec\xf0\x04\x0e4\xab\xb6:j\x86" + operator);
  } else if(isxhashasset(operator)) {
    operator = getscriptbundle(operator);
  }

  operatorskins = operator.operatorskins;
  skin = undefined;

  if(isarray(operatorskins)) {
    foreach(skinwalk in operatorskins) {
      if(!isDefined(skin)) {
        skin = skinwalk;
      }

      if(skinwalk.key === profilechoices[" \xf5\x19\xeb"]) {
        skin = skinwalk;
        break;
      }
    }
  }

  if(isstring(skin.operatorskin)) {
    skin = getscriptbundle("$\xb8U\xa3v!u\a\x18\xba\xb4\x9d\xcdF\x9ea\xd9yX\xce\xd4" + skin.operatorskin);
  } else if(isxhashasset(skin.operatorskin)) {
    skin = getscriptbundle(skin.operatorskin);
  }

  if(!isstruct(skin)) {
    assertmsg("<dev string:x428>");
    return;
  }

  player setclothtype(skin.clothtype ?? "\xa7\x9fa\xf8E|\x93\x8f\xff");
  player setgeartype(skin.geartype ?? "\x92s\xbf\xe8\ayITu");
  viewmodel = operatormodel(skin.modelview, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);
  legmodel = operatormodel(skin.modellegs, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);
  shadowmodel = operatormodel(skin.modelshadow, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);

  if(isDefined(viewmodel)) {
    player setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    player setshadowmodel(shadowmodel);
  }

  rigmodel = operatormodel(skin.modelrig, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);
  rigmodellegs = operatormodel(skin.var_cba624d28104f570, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);
  var_eee393377ff19343 = operatormodel(skin.var_9298a1a5c37de835, profilechoices["\xd9k\xd6\x9f1Q\f\xd2\xac"]);
  player namespace_6341d8b435bf1728::init_player_rig_no_precache(rigmodel, rigmodellegs, var_eee393377ff19343);
  setsaveddvar(@ "hash_d4f3414c2a34e19e", 0);
}

function private operatormodel(model, variation) {
  if(isstring(variation) && isstring(model)) {
    variationmodel = variation + "W\xd3" + model;

    if(modelexists(variationmodel)) {
      return variationmodel;
    }

    setdvarifuninitialized(@ "hash_399d2a061bd2e76c", "<dev string:x4b9>");
    warn = getDvar(@ "hash_399d2a061bd2e76c", "<dev string:x64>");

    if(warn != "<dev string:x64>" && issubstr(variationmodel, warn)) {
      iprintln("<dev string:x4c1>" + variationmodel);
    }
  }

  if(isstring(model)) {
    if(modelexists(model)) {
      return model;
    }

    iprintln("<dev string:x4d8>" + model);
  }

  return undefined;
}

function function_fa417f053c6c2c14() {
  player = self;

  if(!isPlayer(player)) {
    player = level.player;
  }

  result = [];
  skin = int(player getplayerprogression("\xfa(4\xb7\x94\xc6\x95\xc6\xc3", " \xf5\x19\xeb"));
  variation = int(player getplayerprogression("\xfa(4\xb7\x94\xc6\x95\xc6\xc3", "\xd9k\xd6\x9f1Q\f\xd2\xac"));
  identity = int(player getplayerprogression("\xfa(4\xb7\x94\xc6\x95\xc6\xc3", "\xfd\xbd\x90\x19\xabv\x10b"));
  record = int(player getplayerprogression("\xfa(4\xb7\x94\xc6\x95\xc6\xc3", "f<Kn\xe2\xea"));
  globaloptions = getoperatoroptions();

  if(isstruct(globaloptions)) {
    if(isDefined(globaloptions.skins[skin].key)) {
      skin = globaloptions.skins[skin].key;
    }

    if(isDefined(globaloptions.variations[variation].key)) {
      variation = globaloptions.variations[variation].key;
    }

    if(isDefined(globaloptions.identities[identity].key)) {
      identity = globaloptions.identities[identity].key;
    }

    if(isDefined(globaloptions.records[record].key)) {
      record = globaloptions.records[record].key;
    }
  }

  result[" \xf5\x19\xeb"] = skin;
  result["\xd9k\xd6\x9f1Q\f\xd2\xac"] = variation;
  result["\xfd\xbd\x90\x19\xabv\x10b"] = identity;
  result["f<Kn\xe2\xea"] = record;
  return result;
}

function getoperatoroptions() {
  globaloptions = level.gamemodebundle.operatoroptions;

  if(isstring(globaloptions)) {
    globaloptions = getscriptbundle("\xfc0\x8aV\v\x1c\xd0T\xc5\x90>N\xe2\x8d\x9fO}\x9b7\x9ax@\xd3S" + globaloptions);
  } else if(isxhashasset(globaloptions)) {
    globaloptions = getxhashasset(globaloptions);
  }

  return globaloptions;
}

function function_f383d4d9da3293b8() {
  globaloptions = getoperatoroptions();

  if(isstruct(globaloptions)) {
    skin = int(level.player getplayerprogression("\xfa(4\xb7\x94\xc6\x95\xc6\xc3", " \xf5\x19\xeb"));

    if(isDefined(globaloptions.skins[skin].key)) {
      return globaloptions.skins[skin].key;
    }
  }

  return "";
}

function function_bca1b32459e6f60c() {
  globaloptions = getoperatoroptions();

  if(isstruct(globaloptions)) {
    operatorsloaded = function_d55b29eed413ded6("<dev string:x4eb>");

    if(operatorsloaded.size == 0) {
      return;
    }

    setdvarifuninitialized(@ "hash_1e3b9231c04b531b", "<dev string:x64>");
    thread function_9ba72d2fb534f501(@ "hash_1e3b9231c04b531b", &function_e20f6e191bd6bd2e);
    thread function_9ba72d2fb534f501(@ "hash_e7462185849f5a9d", &function_e20f6e191bd6bd2e);
    thread function_9ba72d2fb534f501(@ "hash_97fe38746f58f7dd", &function_e20f6e191bd6bd2e);
    level.operators = spawnStruct();
    level.operators.operators = [];
    level.operators.skins = [];
    level.operators.variations = [];
    skinnames = [];
    variationnames = [];

    foreach(operator in operatorsloaded) {
      level.operators.operators[level.operators.operators.size] = operator;
    }

    foreach(key, value in globaloptions.skins) {
      if(!isDefined(skinnames[value.key])) {
        level.operators.skins[level.operators.skins.size] = [key, value.key];
        skinnames[value.key] = key;
      }
    }

    foreach(key, value in globaloptions.variations) {
      if(!isDefined(variationnames[value.key ?? "<dev string:x4ff>"])) {
        level.operators.variations[level.operators.variations.size] = [key, value.key ?? "<dev string:x4ff>"];
        variationnames[value.key ?? "<dev string:x4ff>"] = key;
      }
    }

    wait 1;

    foreach(operator in operatorsloaded) {
      cmd = "<dev string:x509>" + operator + "<dev string:x52e>" + operator + "<dev string:x548>";
      adddebugcommand(cmd);
    }

    foreach(key, value in globaloptions.skins) {
      cmd = "<dev string:x54e>" + value.key + "<dev string:x56f>" + key + "<dev string:x548>";
      adddebugcommand(cmd);
    }

    foreach(key, value in globaloptions.variations) {
      cmd = "<dev string:x58e>" + (value.key ?? "<dev string:x4ff>") + "<dev string:x5ae>" + key + "<dev string:x548>";
      adddebugcommand(cmd);
    }
  }
}

function function_d0a67d78cdcaaee2() {
  level.operators.oper = (level.operators.oper ?? -1) + 1;

  if(level.operators.oper >= level.operators.operators.size) {
    level.operators.oper = 0;
  }

  setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[level.operators.oper]);
  return level.operators.operators[level.operators.oper];
}

function function_e7d132f1db34a6f6() {
  level.operators.oper = (level.operators.oper ?? 1) - 1;

  if(level.operators.oper < 0) {
    level.operators.oper = level.operators.operators.size - 1;
  }

  setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[level.operators.oper]);
  return level.operators.operators[level.operators.oper];
}

function function_bd1648750b2b7da3() {
  if(isDefined(level.player.dbgoperator)) {
    foreach(value in level.operators.operators) {
      if(value == level.player.dbgoperator) {
        level.operators.oper = index;
        setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[level.operators.oper]);
        break;
      }
    }
  }

  return "<dev string:x64>" + (level.player.dbgoperator ?? "<dev string:x4ff>");
}

function function_defd2928dd93e550() {
  level.operators.skin = (level.operators.skin ?? -1) + 1;

  if(level.operators.skin >= level.operators.skins.size) {
    level.operators.skin = 0;
  }

  if(getDvar(@ "hash_1e3b9231c04b531b", "<dev string:x64>") == "<dev string:x64>") {
    setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[0]);
  }

  setDvar(@ "hash_e7462185849f5a9d", level.operators.skins[level.operators.skin][0]);
  return level.operators.skins[level.operators.skin][1];
}

function function_6bcb10af8b7f7a78() {
  level.operators.skin = (level.operators.skin ?? 1) - 1;

  if(level.operators.skin < 0) {
    level.operators.skin = level.operators.skins.size - 1;
  }

  if(getDvar(@ "hash_1e3b9231c04b531b", "<dev string:x64>") == "<dev string:x64>") {
    setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[0]);
  }

  setDvar(@ "hash_e7462185849f5a9d", level.operators.skins[level.operators.skin][0]);
  return level.operators.skins[level.operators.skin][1];
}

function function_d5bebdd44d851f21() {
  choices = function_fa417f053c6c2c14();

  foreach(entry in level.operators.skins) {
    if(isint(choices["<dev string:x5cc>"]) && entry[0] == choices["<dev string:x5cc>"] || isstring(choices["<dev string:x5cc>"]) && entry[1] == choices["<dev string:x5cc>"]) {
      level.operators.skin = index;
      return level.operators.skins[level.operators.skin][1];
    }
  }

  return "<dev string:x64>" + choices["<dev string:x5cc>"];
}

function function_26e27b92c002b426() {
  level.operators.var = (level.operators.var ?? -1) + 1;

  if(level.operators.var >= level.operators.variations.size) {
    level.operators.var = 0;
  }

  if(getDvar(@ "hash_1e3b9231c04b531b", "<dev string:x64>") == "<dev string:x64>") {
    setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[0]);
  }

  setDvar(@ "hash_97fe38746f58f7dd", level.operators.variations[level.operators.var][0]);
  return level.operators.variations[level.operators.var][1];
}

function function_7027e05ae2fa6a12() {
  level.operators.var = (level.operators.var ?? 1) - 1;

  if(level.operators.var < 0) {
    level.operators.var = level.operators.variations.size - 1;
  }

  if(getDvar(@ "hash_1e3b9231c04b531b", "<dev string:x64>") == "<dev string:x64>") {
    setDvar(@ "hash_1e3b9231c04b531b", level.operators.operators[0]);
  }

  setDvar(@ "hash_97fe38746f58f7dd", level.operators.variations[level.operators.var][0]);
  return level.operators.variations[level.operators.var][1];
}

function function_1b71104a7a120717() {
  choices = function_fa417f053c6c2c14();

  foreach(entry in level.operators.variations) {
    if(isint(choices["<dev string:x5d4>"]) && entry[0] == choices["<dev string:x5d4>"] || isstring(choices["<dev string:x5d4>"]) && entry[1] == choices["<dev string:x5d4>"]) {
      level.operators.var = index;
      return level.operators.variations[level.operators.var][1];
    }
  }

  return "<dev string:x64>" + (choices["<dev string:x5d4>"] == 0 ? "<dev string:x4ff>" : choices["<dev string:x5d4>"]);
}

function function_9ba72d2fb534f501(dvar, func) {
  setdvarifuninitialized(dvar, "<dev string:x64>");
  last = getDvar(dvar, "<dev string:x64>");

  while(true) {
    cur = getDvar(dvar, "<dev string:x64>");

    if(last != cur) {
      self[[func]]();
    }

    last = cur;
    waitframe();
  }
}

function function_e20f6e191bd6bd2e() {
  skin = getdvarint(@ "hash_e7462185849f5a9d", 0);
  variation = getdvarint(@ "hash_97fe38746f58f7dd", 0);
  level.player setplayerprogression("<dev string:x5e1>", "<dev string:x5cc>", skin);
  level.player setplayerprogression("<dev string:x5e1>", "<dev string:x5d4>", variation);
  level.player setoperator(getDvar(@ "hash_1e3b9231c04b531b", "<dev string:x64>"));
}

function debugweaponattachments() {
  self notify("\x8b\xceQK2\xff\x90)\x19\xc3\xcd\xea\xc5\xb7.h");
  self endon("\x8b\xceQK2\xff\x90)\x19\xc3\xcd\xea\xc5\xb7.h");
  setdvarifuninitialized(@ "hash_2e27c23239966936", 0);

  if(!isDefined(self.var_df46cbec60f49778)) {
    self.var_df46cbec60f49778 = [];
  }

  basex = 555;
  basey = 405;
  lastweapon = undefined;

  while(true) {
    clear = 0;

    while(!getdvarint(@ "hash_2e27c23239966936", 0)) {
      while(clear < self.var_df46cbec60f49778.size) {
        self.var_df46cbec60f49778[clear] setdevtext("<dev string:x64>");
        clear++;
      }

      lastweapon = undefined;
      wait 1;
    }

    weapon = self getcurrentweapon();
    logcmd = "<dev string:x4ff>";

    if(isDefined(weapon)) {
      logcmd = "<dev string:x5ee>";
      weapattachments = getweaponattachments(weapon);

      if(!isDefined(weapattachments)) {
        weapattachments = [];
      }

      attachments = utility::array_combine([weapon.basename], weapattachments);
      logcmd = logcmd + weapon.basename + "<dev string:x60c>";

      if(isDefined(attachments)) {
        if(weapattachments.size > 0) {
          logcmd += "<dev string:x611>";
        }

        foreach(i, att in attachments) {
          if(!isDefined(self.var_df46cbec60f49778[i])) {
            hudelem = newhudelem();
            hudelem.alignx = "<dev string:x618>";
            hudelem.x = basex;
            hudelem.y = basey - i * 10;
            hudelem.fontscale = 1;
            hudelem.color = (0.8, 0.8, 0.8);
            hudelem.horzalign = "<dev string:x1f0>";
            hudelem.vertalign = "<dev string:x1f0>";
            self.var_df46cbec60f49778[i] = hudelem;
          }

          hudelem.y = basey - i * 10;

          if(i == 0) {
            self.var_df46cbec60f49778[i] setdevtext("<dev string:x621>" + att + "<dev string:x626>");
          } else {
            self.var_df46cbec60f49778[i] setdevtext(att);
          }

          if(i > 0) {
            if(i > 1) {
              logcmd += "<dev string:x62b>";
            }

            logcmd = logcmd + "<dev string:x60c>" + att + "<dev string:x60c>";
          }

          clear = i + 1;
        }

        if(weapattachments.size > 0) {
          logcmd += "<dev string:x626>";
        }
      }

      logcmd += "<dev string:x630>";
    }

    while(clear < self.var_df46cbec60f49778.size) {
      self.var_df46cbec60f49778[clear] setdevtext("<dev string:x64>");
      clear++;
    }

    if(!(lastweapon === weapon)) {
      print("<dev string:x637>" + logcmd);
      lastweapon = weapon;
    }

    waitframe();
  }
}

function function_a9a4c8a5f556afa7(safestartorigin, var_d7c8f28f371667f5, ignoreentities, collisioncontents, groundclearance) {
  assert(isPlayer(self));
  player = self;

  setdvarifuninitialized(@ "hash_bae83f0c1672eaa4", 0);

  if(istrue(var_d7c8f28f371667f5)) {
    if(!isDefined(collisioncontents)) {
      collisioncontents = trace::create_default_contents();
    }

    trace = trace::player_trace(safestartorigin, player.origin, undefined, ignoreentities, collisioncontents, 1, groundclearance);

    if(trace["\xda\x16\x81\aw}^i"] < 1) {
      movetopos = trace["1\xfd\x12\"\x9a\a\xf8\xb9\xbd\xf2\x16^\xb2M"];

      if(getdvarint(@ "hash_bae83f0c1672eaa4", 0)) {
        duration = 1000;
        color = (1, 1, 0);
        sphere(safestartorigin, 5, color, 1, duration);
        color = (1, 0, 0);
        sphere(player.origin, 5, color, 1, duration);
        color = (0, 1, 1);
        trace::draw_trace(trace, color, 1, duration);
        color = (0, 1, 0);
        sphere(movetopos, 5, color, 1, duration);
        iprintlnbold("<dev string:x652>" + movetopos);
      }

      player setOrigin(movetopos);
    }

    return;
  }

  step = 10;
  trace = playerphysicstrace(player.origin + (0, 0, 1), player.origin, undefined, undefined, ignoreentities, 1);
  trace_pos = trace["\xc1\xbd\xdci\xe8i{7"];

  if(lengthsquared(trace_pos - player.origin) > 0.02) {
    trace_pos = playerphysicstrace(safestartorigin + (0, 0, step), player.origin + (0, 0, step), undefined, undefined, ignoreentities);

    if(trace_pos[0] != player.origin[0] || trace_pos[1] != player.origin[1]) {
      trace_pos += vectorNormalize(safestartorigin - player.origin);
    }

    trace_pos = playerphysicstrace(trace_pos, trace_pos - (0, 0, step), undefined, undefined, ignoreentities);
    var_ecf6f359db96f07b = playerphysicstrace(trace_pos + (0, 0, 1), trace_pos, undefined, undefined, ignoreentities);

    if(trace_pos != var_ecf6f359db96f07b) {
      if(getdvarint(@ "hash_bae83f0c1672eaa4", 0)) {
        msg = "<dev string:x677>" + safestartorigin[0] + "<dev string:x6ac>" + safestartorigin[1] + "<dev string:x6ac>" + safestartorigin[2] + "<dev string:x6b2>";
        iprintlnbold(msg);
        println(msg + "<dev string:x6b8>");
        trace::draw_trace(trace, (1, 1, 0), 1, 1000);
        iprintlnbold("<dev string:x652>" + trace_pos);
      }

      trace_pos = safestartorigin;
    }

    player setOrigin(trace_pos);
  }
}

function canstand(contentoverride, startz = 5) {
  assert(isPlayer(self));

  if(self getstance() == "\x8b\x90\xb5\xc4W") {
    return true;
  }

  if(!self isstanceallowed("\x8b\x90\xb5\xc4W")) {
    return false;
  }

  capsule = self getcollision("\x8b\x90\xb5\xc4W");
  playerradius = capsule.capsule_radius;
  playerheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius - startz;
  trace = trace::capsule_get_closest_point(self.origin + (0, 0, startz), playerradius, playerheight, undefined, 0, self, contentoverride);

  if(trace[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
    return true;
  }

  return false;
}

function challengeaward(challenge) {
  if(!isDefined(level.fnchallengeaward)) {
    iprintln("<dev string:x6bd>");

    return;
  }

  self thread[[level.fnchallengeaward]](challenge);
}

function challengeprogressadd(challenge, progressadd = 1, autoaward = 1) {
  progresscur = challengeprogressget(challenge);
  progressnew = progresscur + progressadd;
  challengeprogressset(challenge, progressnew, autoaward);
}

function challengeprogressset(challenge, progress, autoaward = 1) {
  if(!isDefined(level.var_a27fc34c5fa1412e)) {
    iprintln("<dev string:x6e2>");

    return;
  }

  return self[[level.var_a27fc34c5fa1412e]](challenge, progress, autoaward);
}

function challengeprogressget(challenge) {
  if(!isDefined(level.var_71254f85261cde3a)) {
    iprintln("<dev string:x70d>");

    return 0;
  }

  return self[[level.var_71254f85261cde3a]](challenge);
}

function function_90882004a3e74103(active, bufferdist = 200) {
  self notify("\x92\xf8\xa1\xcaJ\x93\xa5\xa0l>Z\xb6\x94\x9b\xe0E");
  self endon("\x92\xf8\xa1\xcaJ\x93\xa5\xa0l>Z\xb6\x94\x9b\xe0E");
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(istrue(active)) {
    function_1ce9fde87cbd0430(1, bufferdist);
    waitframe();
  }

  function_1ce9fde87cbd0430(0);
}

function function_1ce9fde87cbd0430(active, bufferdist = 200, usebasefov = 0) {
  assert(isPlayer(self));

  if(!istrue(active)) {
    if(isarray(self.var_24d4d3370dc2a347)) {
      foreach(ent in self.var_24d4d3370dc2a347) {
        if(!isent(ent)) {
          continue;
        }

        ent castshadows();
      }
    }

    self.var_24d4d3370dc2a347 = undefined;

    if(isDefined(level.var_6513f9937e4ec4ea)) {
      level.var_6513f9937e4ec4ea setdevtext("<dev string:x64>");
    }

    return;
  }

  if(istrue(active)) {
    setdevdvarifuninitialized(@ "hash_5e6e68433b408eef", 0);

    if(!isDefined(self.var_24d4d3370dc2a347)) {
      self.var_24d4d3370dc2a347 = [];
    }

    sightlinestart = self getEye();
    sightlineend = sightlinestart + anglesToForward(self getplayerangles()) * 20000;

    if(istrue(usebasefov)) {
      tantheta = tan(getdvarfloat(@ "cg_targetbasefov", 65) * 0.5);
    } else {
      tantheta = tan(getdvarfloat(@ "cg_fov", 65) * 0.5);
    }

    debugging = getdvarint(@ "hash_5e6e68433b408eef", 0);
    countshadows = 0;
    countnoshadows = 0;

    if(debugging && !isDefined(level.var_6513f9937e4ec4ea)) {
      level.var_6513f9937e4ec4ea = newhudelem();
      level.var_6513f9937e4ec4ea.alignx = "<dev string:x1e1>";
      level.var_6513f9937e4ec4ea.aligny = "<dev string:x1e9>";
      level.var_6513f9937e4ec4ea.vertalign = "<dev string:x1e9>";
      level.var_6513f9937e4ec4ea.horzalign = "<dev string:x1e1>";
      level.var_6513f9937e4ec4ea.font = "<dev string:x738>";
      level.var_6513f9937e4ec4ea.x = 50;
      level.var_6513f9937e4ec4ea.y = 50;
      level.var_6513f9937e4ec4ea.fontscale = 1;
      level.var_6513f9937e4ec4ea.color = (0.6, 0.6, 0.6);
    }

    checkents = getaiarray();

    foreach(ent in checkents) {
      entnum = ent getentitynumber();
      origin = ent getcentroid();
      var_d0d841ac2f6aba65 = pointonsegmentnearesttopoint(sightlinestart, sightlineend, origin);
      opposite = distance(var_d0d841ac2f6aba65, origin);
      adjacent = distance(var_d0d841ac2f6aba65, sightlinestart);
      castshadow = opposite - bufferdist < adjacent * tantheta;

      if(castshadow) {
        countshadows++;

        if(debugging) {
          line(origin, var_d0d841ac2f6aba65, (1, 0, 0), 1, 1, 1);
        }

        self.var_24d4d3370dc2a347[entnum] = undefined;
        ent castshadows();
        continue;
      }

      countnoshadows++;

      self.var_24d4d3370dc2a347[entnum] = ent;
      ent dontcastshadows();
    }

    if(debugging) {
      level.var_6513f9937e4ec4ea setdevtext("<dev string:x746>" + countshadows + "<dev string:x753>" + countnoshadows);
    }
  }
}