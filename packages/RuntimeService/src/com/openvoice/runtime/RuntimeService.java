package com.openvoice.runtime;

import android.app.Service;
import android.content.Intent;
import android.content.Context;
import android.os.Parcel;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;
import android.net.NetworkInfo;
import android.net.ConnectivityManager;
public class RuntimeService extends Service{

	String TAG = getClass().getSimpleName();
	RuntimeNative mRuntimeNative = null;
	
	public RuntimeService(){
		Log.e(TAG, "RuntimeService  created ");
		mRuntimeNative = RuntimeNative.asInstance();
		mRuntimeNative.init();
		mRuntimeNative.addBinder(new RuntimeProxy());
		ConnectivityManager cm = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo mNetworkInfo = cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
		if(mNetworkInfo.isConnected()){
			mRuntimeNative.networkStateChange(true);
		}
	}

	private void setSirenState(int state){
		mRuntimeNative.setSirenState(state);
	}

	class RuntimeProxy extends IRuntimeService.Stub{

		@Override
		public void nativeNlpMessage(String asr, String nlp, String action, int type){
			Log.e(TAG, "asr\t" + asr);
			Log.e(TAG, "nlp\t" + nlp);
			Log.e(TAG, "action\t" + action);
		}
	
		@Override
		public void sirenEvent(int event, double sl_degree, int has_sl){
			mRuntimeNative.sirenEvent(event, sl_degree, has_sl);
		}
	}	

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}
}