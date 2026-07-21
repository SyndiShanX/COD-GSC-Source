/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\traverse\shared.gsc
***********************************************/

teleportthread(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self notify("_encstr_8ED412BD73810BC8518FFB5A76634B6852A532EF");
  self endon("_encstr_8ED412BD73810BC8518FFB5A76634B6852A532EF");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self forceteleport(self.origin + var_2);
    wait 0.05;
  }
}

teleportthreadex(var_0, var_1, var_2, var_3) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self notify("_encstr_8ED412BD73810BC8518FFB5A76634B6852A532EF");
  self endon("_encstr_8ED412BD73810BC8518FFB5A76634B6852A532EF");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0)
    wait(var_1);

  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0)
    self setflaggedanimknoball("_encstr_84A00D5088A3F30F9B966981E03008", self.traverseanim, self.traverseanimroot, 1, 0.2, var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    wait 0.05;
  }

  if(isDefined(var_3) && var_3 < 1.0)
    self setflaggedanimknoball("_encstr_84A00D5088A3F30F9B966981E03008", self.traverseanim, self.traverseanimroot, 1, 0.2, 1.0);
}

dotraverse(var_0) {}

handletraversenotetracks(var_0) {
  if(var_0 == "_encstr_BEF60F496BB29C80C26A112ED7BDE8D57A")
    return handletraversedeathnotetrack();
  else if(var_0 == "_encstr_BAC10F7B2260ABC723A241D95645843248")
    return handletraversealignment();
  else if(var_0 == "_encstr_95A30E733089DEFA550EE711FD3D1280")
    return handletraversedrop();
}

handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var_0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var_0[randomint(var_0.size)];
    self.traversedeathindex++;
  }
}

handletraversealignment() {
  self animmode("_encstr_B69807B9DE36C69683");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var_0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var_0 - self.traverseheight);
  }
}

handletraversedrop() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self getanimtime(self.traverseanim);
  var_5 = getmovedelta(self.traverseanim, var_4, 1.0);
  var_6 = getanimlength(self.traverseanim);
  var_7 = 0 - var_5[2];
  var_8 = var_7 - var_3;

  if(var_7 < var_3)
    var_9 = var_7 / var_3;
  else
    var_9 = 1;

  var_10 = (var_6 - var_4) / 3.0;
  var_11 = ceil(var_10 * 20);
  thread teleportthreadex(var_8, 0, var_11, var_9);
  thread finishtraversedrop(var_1[2]);
}

finishtraversedrop(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self animmode("_encstr_8AD6086722F1FB98F58B");
      break;
    }

    wait 0.05;
  }
}

donothingfunc() {
  self animmode("_encstr_A1370EF3FA638AFB695A587B03B42E57");
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
}

dog_jump_down(var_0, var_1, var_2, var_3) {}

seeker_traversal() {
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
}