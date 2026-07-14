/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\actor_fidgets.gsc
*********************************************/

#using scripts\common\scene;
#using scripts\engine\utility;
#namespace actor_fidgets;

function handle_fidgets(scene_struct, fidget_array, var_bd4ff1b869abe5fe, disable_flag) {
  assert(isDefined(scene_struct) && isDefined(scene_struct.script_scenescriptbundle), "<dev string:x24>");
  assert(isDefined(fidget_array), "<dev string:x54>");
  self.fidget_struct = spawnStruct();
  self.fidget_scene = scene_struct;
  self.var_689278c2b672837a = scene_struct.script_scenescriptbundle;
  self.var_d4f2592212110b6f = disable_flag;
  self.fidgets = [];
  function_fc8ef369217dd227(fidget_array);

  if(isDefined(var_bd4ff1b869abe5fe)) {
    function_fc8ef369217dd227(var_bd4ff1b869abe5fe, 1);
  }

  thread start_fidgets();
}

function pause_fidgets(pause = 1) {
  if(pause) {
    utility::ent_flag_set("\xfa\xd6\xbax\"\xbb\x8dsi\x8f\xcd\x10\x19");
    return;
  }

  utility::ent_flag_clear("\xfa\xd6\xbax\"\xbb\x8dsi\x8f\xcd\x10\x19");
}

function add_fidget(fidget_name, once_only, scene_override) {
  function_fc8ef369217dd227([fidget_name], once_only, scene_override);
}

function function_fc8ef369217dd227(fidget_names, once_only, scene_override) {
  assert(isDefined(self.fidgets), "<dev string:x86>");
  new_fidgets = [];

  foreach(fidget in fidget_names) {
    fidget_struct = fidget;

    if(!isstruct(fidget_struct)) {
      fidget_struct = spawnStruct();
      fidget_struct.fidget_name = fidget;
    }

    if(isDefined(scene_override)) {
      scene_name = scene_override;

      if(!isstring(scene_override)) {
        assert(isDefined(scene_override.script_scenescriptbundle), "<dev string:xd0>");
        scene_name = scene_override.script_scenescriptbundle;
      }

      if(scene_name != self.var_689278c2b672837a) {
        fidget_struct.scene_name = scene_name;
      }
    }

    if(istrue(once_only)) {
      fidget_struct.once_only = 1;
    }

    new_fidgets[new_fidgets.size] = fidget_struct;
  }

  self.fidgets = utility::array_combine(self.fidgets, new_fidgets);
  self notify("\xfecO\xdc\xb39\"\xc5I\x86o\xb0\x9d");
}

function function_5dd6874c98a73076(var_6ede823a5cbf2c1a, var_a65f1de3c35398c, var_32d124096800f55b) {
  if(isDefined(var_6ede823a5cbf2c1a)) {
    self.var_6ede823a5cbf2c1a = var_6ede823a5cbf2c1a;
  }

  if(isDefined(var_a65f1de3c35398c)) {
    self.var_a65f1de3c35398c = var_a65f1de3c35398c;
  }

  if(isDefined(var_32d124096800f55b)) {
    self.var_32d124096800f55b = var_32d124096800f55b;
  }
}

function interrupt_fidget() {
  if(utility::ent_flag("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0")) {
    utility::ent_flag_set("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
  }
}

function stop_fidgets() {
  self notify("\x05\x8d\x7f\xd1\x8bX\x13K\xc3\x7f\xec\x97");
}

function start_fidgets() {
  self notify("\x05\x8d\x7f\xd1\x8bX\x13K\xc3\x7f\xec\x97");
  self endon("\x05\x8d\x7f\xd1\x8bX\x13K\xc3\x7f\xec\x97");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.fidgets)) {
    return;
  }

  self.last_fidget = "";

  while(self.fidgets.size > 0) {
    utility::ent_flag_clear("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
    wait randomintrange(12, 24);
    function_54be63c34e459ab4();
    start_idx = -1;
    fidget = undefined;
    dist_to_player = distance2d(self.origin, level.player.origin);
    fidget_name = "";

    for(var_b3a06ee625398a7d = 0; start_idx == -1 || fidget_name == self.last_fidget && dist_to_player <= var_b3a06ee625398a7d || isDefined(fidget) && istrue(fidget.once_only) && level utility::flag("IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16"); var_b3a06ee625398a7d = 8 * fidget_time) {
      if(start_idx == -1) {
        start_idx = randomintrange(0, self.fidgets.size);
        fidget_idx = start_idx;
      } else {
        fidget_idx++;

        if(fidget_idx >= self.fidgets.size) {
          fidget_idx = 0;
        }

        if(fidget_idx == start_idx) {
          fidget_idx = -1;
          break;
        }
      }

      fidget = self.fidgets[fidget_idx];
      fidget_name = fidget.fidget_name;
      fidget_time = self.fidget_scene scene::function_be97e534be3fddee(fidget_name);
    }

    if(fidget_idx > -1) {
      fidget_name = fidget.fidget_name;
      var_689278c2b672837a = fidget.scene_name ?? self.var_689278c2b672837a;
      once_only = fidget.once_only ?? 0;
      self.last_fidget = fidget_name;
      function_7fa78451ae3b06c2(self.fidget_struct, var_689278c2b672837a, fidget_name, fidget.doskip);
      utility::function_18e9f1084badc1c7("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0");

      if(once_only) {
        self.fidgets = arrayremove(self.fidgets, fidget);
      }
    }
  }
}

function private function_54be63c34e459ab4() {
  waitopen_flags = ["IDg(\xd4}\x0e\fk\x1f\xf8\x10\xe1X}\x8d\x0e\x16", "\x8b\xbe\x10'\n\t\x1d4\xc7`\x9a\xe1\x9dK\xeb\xa1\xb6`\x8d\xfe\xd5\x97\x8e!\x13\xad\x7f", "\xfa\xd6\xbax\"\xbb\x8dsi\x8f\xcd\x10\x19"];

  if(isDefined(self.var_d4f2592212110b6f)) {
    waitopen_flags[waitopen_flags.size] = self.var_d4f2592212110b6f;
  }

  utility::function_8530ca31a17b1a44(waitopen_flags);

  while(distance2d(self.origin, level.player.origin) < 80) {
    waitframe();
    utility::function_8530ca31a17b1a44(waitopen_flags);
  }
}

function private function_7fa78451ae3b06c2(struct, scene, shot, doskip) {
  self endon("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
  utility::ent_flag_set("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0");
  utility::ent_flag_clear("\xc1\xafD;\xd4^\xc3\xd7\\Bqc\x04\x98\xe5:\xf8\xd4\xd7\xf5");
  thread function_84537040ea1d5ea0(struct, scene, shot, doskip);
  struct scene::play(self, shot, scene);
  self notify("\x11\x17\xc3\x9d\x03X9\x90\xea\xdc0\x03=KWy\xa97,\x1d\x83\x88d");
  thread function_545155873b2ad7b5(struct, scene);
}

function private function_84537040ea1d5ea0(struct, scene, shot, doskip) {
  self endon("\x05\x8d\x7f\xd1\x8bX\x13K\xc3\x7f\xec\x97");
  self notify("\x11\x17\xc3\x9d\x03X9\x90\xea\xdc0\x03=KWy\xa97,\x1d\x83\x88d");
  self endon("\x11\x17\xc3\x9d\x03X9\x90\xea\xdc0\x03=KWy\xa97,\x1d\x83\x88d");
  utility::ent_flag_wait("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
  self notify("\xe7]\x99:-k\x12\xa7\xd8!2\xe1\xbdz\x9c\x81");
  fade_time = 0;

  if(istrue(self.var_97c29311fb5295a2)) {
    fade_time = 0.5;
  }

  if(doskip ?? 1) {
    struct scene::skip(shot, 0.25, fade_time);
  }

  thread function_545155873b2ad7b5(struct, scene);
}

function private function_545155873b2ad7b5(struct, scene) {
  self endon("\x19\xf3\x13d\xd7T,2w-)\xd52\xca\x98\xcd");

  if(!utility::ent_flag("\xc1\xafD;\xd4^\xc3\xd7\\Bqc\x04\x98\xe5:\xf8\xd4\xd7\xf5")) {
    struct = self.var_32d124096800f55b ?? struct;
    scene = self.var_a65f1de3c35398c ?? scene;
    shot = self.var_6ede823a5cbf2c1a ?? "J\xd0\xf5\xea'\x96$A\xc6";
    struct thread scene::play([self], shot, scene);
  }

  utility::ent_flag_clear("\xc8\x8dH\xfa,\xe2\x82 \xe5\xfb;\xd0");
}