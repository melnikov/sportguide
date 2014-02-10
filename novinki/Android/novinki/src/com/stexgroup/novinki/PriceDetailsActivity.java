package com.stexgroup.novinki;

import android.app.Activity;
import android.os.Bundle;

public class PriceDetailsActivity extends Activity {

	
	public static String TYPE_VIEW = "TYPE_PODEM";
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		int layourtId = getIntent().getExtras().getInt(TYPE_VIEW);
		setContentView(layourtId);
	}
}
