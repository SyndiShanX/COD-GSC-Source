/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\slide_across_car.gsc
******************************************************/

main() {
  if(self.type == "dog") {
    func_102DE();
    return;
  }

  func_102DF();
}

func_102DF() {
  var_0 = [];
  var_0["traverseAnim"] = % slide_across_car;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_0);
    return;
  }

  self waittill("killanimscript");
}

func_102DE() {
  self endon("killanimscript");
  self func_83C4("noclip");
  var_0 = self getspectatepoint();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim( % root, 0.1);
  self func_82EA("traverse", level.var_58C7["jump_up_40"], 1, 0.1, 1);
  scripts\anim\shared::donotetracks("traverse");
  playworldsound("anml_dog_bark", self gettagorigin("tag_eye"));
  self clearanim( % root, 0);
  self func_82EA("traverse", level.var_58C7["jump_down_40"], 1, 0, 1);
  scripts\anim\shared::donotetracks("traverse");
  self func_83C4("gravity");
}