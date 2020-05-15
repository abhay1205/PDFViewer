

import 'package:taskIntern/arch/models/appstate.dart';
import 'package:taskIntern/arch/redux/actions.dart';

AppState appReducer(state, action){
  return AppState(
    auth: authReducer(state.auth, action),
    name: nameReducer(state.name, action),
    address: addressReducer(state.address, action),
    phoneNo: phoneNoReducer(state.phoneNo, action),
  );
}

authReducer(auth, action){
  if (action is GetInfoAction){
    return action.auth;
  }
  return auth;
}

nameReducer(name, action){
  if (action is GetInfoAction){
    return action.name;
  }
  return name;
}

addressReducer(address, action){
  if (action is GetInfoAction){
    return action.address;
  }
  return address;
}
phoneNoReducer(phoneNo, action){
  if (action is GetInfoAction){
    return action.phoneNo;
  }
  return phoneNo;
}