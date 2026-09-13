/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\melee.gsc
***********************************************/

on_execution_begin(asmname, statename, params) {
  if(istrue(self.bhasriotshieldattached))
    scripts\asm\soldier\death::detachriotshield();

  _id_BB2F1C8715395934 = 40;
  halfheight = 40;
  self _meth_4CD0EAF5381F92DB(0);
  _id_CC2828DA32453F24 = self getexecutionpartner();

  if(isDefined(_id_CC2828DA32453F24)) {
    pos = (self.origin + _id_CC2828DA32453F24.origin) * 0.5;
    level thread execution_obstacle(pos, _id_BB2F1C8715395934, halfheight);
  }
}

execution_obstacle(pos, _id_BB2F1C8715395934, halfheight) {
  _id_48E1C3E32A05C3BF = (0, 0, 0);
  _id_9794CF618646A8BD = createnavbadplacebyshape(pos, _id_48E1C3E32A05C3BF, 6, _id_BB2F1C8715395934, halfheight);
  wait 3;
  destroynavobstacle(_id_9794CF618646A8BD);
}