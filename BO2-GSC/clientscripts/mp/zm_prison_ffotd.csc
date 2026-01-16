/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_prison_ffotd.csc
************************************************/

#include clientscripts\mp\_utility;

main_start() {
  level thread fix_zfighting_models_ffotd();
  level thread hide_bad_models_ffotd();
}

fix_zfighting_models_ffotd() {
  pos_x = 1928;

  for(i = 0; i < 8; i++) {
    catwalk_supports[i] = findstaticmodelindex((pos_x, 9560, 1544));
    pos_x = pos_x - 80;
  }

  foreach(support_index in catwalk_supports) {
    if(isDefined(support_index))
      hidestaticmodel(support_index);
  }
}

hide_bad_models_ffotd() {
  model_01_index = findstaticmodelindex((512, 9689.75, 1572));

  if(isDefined(model_01_index))
    hidestaticmodel(model_01_index);

  model_02_index = findstaticmodelindex((176.5, 8713.5, 830.25));

  if(isDefined(model_02_index))
    hidestaticmodel(model_02_index);

  model_03_index = findstaticmodelindex((133, 8683.5, 825.75));

  if(isDefined(model_03_index))
    hidestaticmodel(model_03_index);

  model_04_index = findstaticmodelindex((2894, 9876.75, 1347.25));

  if(isDefined(model_04_index))
    hidestaticmodel(model_04_index);

  model_05_index = findstaticmodelindex((2923.5, 9857.5, 1351.25));

  if(isDefined(model_05_index))
    hidestaticmodel(model_05_index);
}