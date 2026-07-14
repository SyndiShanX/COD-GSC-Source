/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\pip_util.gsc
**************************************/

#using scripts\engine\sp\utility;
#namespace pip_util;

function pip_init() {
  println("<dev string:x24>");
}

function pip_on_ent(ent, tag, fov, origin_offset, angles_offset, no_hud) {
  if(getdvarint(@ "e3")) {
    return;
  }

  if(gettime() < 500) {
    println("<dev string:x67>");
    wait 0.5;
  }

  if(!isDefined(tag)) {
    iprintlnbold("<dev string:xba>");

    return;
  }

  if(!isDefined(level.pip)) {
    level.pip = level.player newpip();
  }

  if(pip_is_active()) {
    iprintln("<dev string:x100>");

    return;
  }

  level.pip.enableshadows = 1;
  level.pip.rendertotexture = 1;
  level.pip.clipdistance = 5000;
  level.pip.nearz = 2;
  level.pip.aspectratio = 1;
  level.pip.origin_offset = (0, 0, 0);
  level.pip.angles_offset = (0, 0, 0);
  level.pip.tag = tag;
  level.pip.fov = fov ?? 30;

  if(isDefined(origin_offset)) {
    level.pip.origin_offset = origin_offset;
  }

  if(isDefined(angles_offset)) {
    level.pip.angles_offset = angles_offset;
  }

  level.pip.entity = ent;
  level.pip.enable = 1;
  level.pip.freecamera = 1;
  setomnvar("\xae-\xaf\xe0Z\x0e\xbe7ta\xd1-c", 0);
  setomnvar("\x1b\xcc\xf9\xf0\xe1kD\xd67\xb1\x92!f}\x18\x8e\xf7W\x1fu\xeai\x0f", "oA\xb6\x0e\xc1vb\x80\x14\x9c\xfb\x9b\xe9zG\x0e \x04\xe3'\xf1\xb5");
  setomnvar("\xe6%{\xbai\x1d\xcb\xbca\xfd\xf8\xe1\xafga\x16\xa7\xf5\x12\xf1\xc8O\xac\x86<\xcd", "g\x94\xd8cF\xef\x83$\xc6<t\xa6:\a\x1d\xc4)B>\x13\x9e\x92Z9\x88");
  setomnvar("\xd9\xa9\xb7I[\xc4\xa5zNz4Gac'\x19\xf4\x94\x05", 1);

  if(!isDefined(no_hud)) {
    setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 1);
    setomnvar("a\xfb\"\xe1\xbb\x14\x8b\n]\aHi\x9dk\x16q\x9d\x1c\xc2-\x17\xdd\x15\x12\xe0", 0);
  }
}

function bink_pip(bink_name) {
  level.player playSound("\xc5\x14F\r\xf7\xd4\xdc\xbd\xa5\xd4\xd1\xd8\x17\xe6`%V\xd6#");
  setomnvar("\x1b\xcc\xf9\xf0\xe1kD\xd67\xb1\x92!f}\x18\x8e\xf7W\x1fu\xeai\x0f", "oA\xb6\x0e\xc1vb\x80\x14\x9c\xfb\x9b\xe9zG\x0e \x04\xe3'\xf1\xb5");
  setomnvar("\xe6%{\xbai\x1d\xcb\xbca\xfd\xf8\xe1\xafga\x16\xa7\xf5\x12\xf1\xc8O\xac\x86<\xcd", "g\x94\xd8cF\xef\x83$\xc6<t\xa6:\a\x1d\xc4)B>\x13\x9e\x92Z9\x88");
  stopcinematicingame();
  setsaveddvar(@ "bg_cinematicfullscreen", "\xfe");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
  setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 1);
  wait 0.05;
  setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 0);
  wait 0.05;
  setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 1);
  cinematicingame(bink_name);

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  stopcinematicingame();
  setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 0);
  level.player playSound("\xd6REE2\x97A>*.\x98Y\xd5\xfbL\x06\xc2\x8fS\x9d");
  setsaveddvar(@ "bg_cinematicfullscreen", "\x87");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
}

function pip_visionset(vision) {
  level.pip.activevisionset = "\x84L\x12\xf3\xde";
  level.pip.activevisionsetduration = 0.5;
  level.pip.visionsetnaked = vision;
}

function pip_close() {
  if(getdvarint(@ "e3")) {
    return;
  }

  if(!isDefined(level.pip)) {
    return;
  }

  setomnvar("\x9e\xb5\x8f\xdeb\xa1\xe9\xd6\xf3\xce\xa6", 0);
  setomnvar("a\xfb\"\xe1\xbb\x14\x8b\n]\aHi\x9dk\x16q\x9d\x1c\xc2-\x17\xdd\x15\x12\xe0", 1);
  level.pip.enable = 0;
  level notify("g\xc7\x15\x979(\xa0\xaf\xaf\xb6");
}

function pip_is_active() {
  return isDefined(level.pip) && isDefined(level.pip.enable) && level.pip.enable;
}

function pip_dialogue(the_line) {
  face_pip();
  utility_sp::smart_dialogue_generic(the_line);
  pip_close();
}

function face_pip(no_hud) {
  switch (tolower(self.unittype)) {
    case #"hash_198d036c171c0b3f":
      pip_on_ent(self, "\xc7\xae?f\x10\xbcr", 29, (18, 7, 1), (0, 200, 3), no_hud);
      break;
    case #"hash_8b0d967838e55b97":
      pip_on_ent(self, "4\xfc\xa51\xc7\xf6\tc\bP", 13, (150, 0, 20), (8.5, 180, 0), no_hud);
      break;
    default:
      pip_on_ent(self, "\xc7\xae?f\x10\xbcr", 29, (18, 7, -1), (0, 200, 3), no_hud);
      level.pip.nearz = 17;
      break;
  }
}

function pip_vo() {
  face_pip();
  self waittill("\xc66\xdbne\xeb\x1c\x96\x83");
  pip_close();
}