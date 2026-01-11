/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_dev.gsc
*****************************************************/

init() {
  SetDevDvarIfUninitialized("debug_reflection", "0");

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread updateReflectionProbe();
  }
}

updateReflectionProbe() {
  for(;;) {
    if(GetDvarInt("debug_reflection") == 1) {
      if(!isDefined(self.debug_reflectionobject)) {
        self.debug_reflectionobject = spawn("script_model", self getEye() + ((anglesToForward(self.angles) * 100)));
        self.debug_reflectionobject setModel("test_sphere_silver");
        self.debug_reflectionobject.origin = self getEye() + ((anglesToForward(self getplayerangles()) * 100));
        self thread reflectionProbeButtons();
      }
    } else if(GetDvarInt("debug_reflection") == 0) {
      if(isDefined(self.debug_reflectionobject)) {
        self.debug_reflectionobject delete();
      }
    }

    wait(0.05);
  }
}

reflectionProbeButtons() {
  offset = 100;
  offsetinc = 50;

  while(GetDvarInt("debug_reflection") == 1) {
    if(self buttonpressed("BUTTON_X")) {
      offset += offsetinc;
    }
    if(self buttonpressed("BUTTON_Y")) {
      offset -= offsetinc;
    }
    if(offset > 1000) {
      offset = 1000;
    }
    if(offset < 64) {
      offset = 64;
    }

    self.debug_reflectionobject.origin = self getEye() + ((anglesToForward(self GetPlayerAngles()) * offset));

    wait .05;
  }
}
# /