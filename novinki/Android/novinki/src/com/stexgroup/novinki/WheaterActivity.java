package com.stexgroup.novinki;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.androidquery.AQuery;
import com.androidquery.callback.AjaxStatus;
import com.androidquery.util.XmlDom;
import com.stexgroup.novinki.customviews.TextViewMainTheme;
import com.stexgroup.novinki.utils.Weater;

public class WheaterActivity extends Activity implements OnClickListener {

	AQuery aq;
	
	TextViewMainTheme tvDay1;
	TextViewMainTheme tvDay2;
	TextViewMainTheme tvDay3;
	
	TextViewMainTheme tvTime1;
	TextViewMainTheme tvTime2;
	TextViewMainTheme tvTime3;
	
	TextViewMainTheme tvGradus1;
	TextViewMainTheme tvGradus2;
	TextViewMainTheme tvGradus3;
	
	ImageView ivWether1;
	ImageView ivWether2;
	ImageView ivWether3;
	
	TextViewMainTheme tvHumid1;
	TextViewMainTheme tvHumid2;
	TextViewMainTheme tvHumid3;
	
	ImageView ivRoza1;
	ImageView ivRoza2;
	ImageView ivRoza3;
	
	TextViewMainTheme tvRoza1;
	TextViewMainTheme tvRoza2;
	TextViewMainTheme tvRoza3;
	
	TextViewMainTheme tvRozaSpeed1;
	TextViewMainTheme tvRozaSpeed2;
	TextViewMainTheme tvRozaSpeed3;
	
	String[] windDir = {"С", "С-В", "В", "Ю-В", "Ю", "Ю-З", "З", "С-З"};
	
	LinearLayout llContainer;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_whearter);
		
		llContainer = (LinearLayout) findViewById(R.id.linear_layout_container);
		llContainer.setVisibility(View.INVISIBLE);
		
		tvDay1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_day);
		tvDay2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_day);
		tvDay3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_day);
		
		tvTime1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_time);
		tvTime2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_time);
		tvTime3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_time);
		
		tvGradus1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_graduce);
		tvGradus2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_graduce);
		tvGradus3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_graduce);
		
		ivWether1 = (ImageView) findViewById(R.id.image_view_w1);
		ivWether2 = (ImageView) findViewById(R.id.image_view_w2);
		ivWether3 = (ImageView) findViewById(R.id.image_view_w3);
		
		tvHumid1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_humidity);
		tvHumid2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_humidity);
		tvHumid3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_humidity);
		
		ivRoza1 = (ImageView) findViewById(R.id.image_view_w1_roza);
		ivRoza2 = (ImageView) findViewById(R.id.image_view_w2_roza);
		ivRoza3 = (ImageView) findViewById(R.id.image_view_w3_roza);
		
		tvRoza1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_roza);
		tvRoza2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_roza);
		tvRoza3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_roza);
		
		tvRozaSpeed1 = (TextViewMainTheme) findViewById(R.id.text_view_w1_roza_speed);
		tvRozaSpeed2 = (TextViewMainTheme) findViewById(R.id.text_view_w2_roza_speed);
		tvRozaSpeed3 = (TextViewMainTheme) findViewById(R.id.text_view_w3_roza_speed);
	
		aq = new AQuery(this);
		
		if (isOnLine(this)){
			xml_ajax();
		}else{
			Toast.makeText(this, "Нет соединения с интернет или сервер погоды не отвечает.", Toast.LENGTH_LONG).show();
		}
		
	}
	
	public void xml_ajax(){         
        String url = "http://informer.gismeteo.ru/xml/27553_1.xml";
        aq.progress(getProgressDialog(this)).ajax(url, XmlDom.class, this, "weaterCb");           
	}
	
	public static boolean isOnLine(Context c) {
		ConnectivityManager cm = (ConnectivityManager) c
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		if (cm == null)
			return false;
		return (cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo()
				.isConnectedOrConnecting());
	}
	
	public ProgressDialog getProgressDialog(Activity act) {
		ProgressDialog dialog = new ProgressDialog(act);
		dialog.setIndeterminate(true);
		dialog.setCancelable(false);
		dialog.setInverseBackgroundForced(false);
		dialog.setCanceledOnTouchOutside(false);
		dialog.setMessage(act.getString(R.string.progress_loading));
		return dialog;
	}
	
	public void weaterCb(String url, XmlDom xml, AjaxStatus status){

        List<XmlDom> entries = xml.tags("FORECAST");               
        List<Weater> days = new ArrayList<Weater>();
                
        for(XmlDom entry: entries){
        	
        	Weater weather = new Weater();
        	weather.day = parseString(entry.attr("day"));
        	weather.month = parseString(entry.attr("month"));
        	weather.year = parseString(entry.attr("year"));
        	weather.hour = parseString(entry.attr("hour"));
        	weather.predict = parseString(entry.attr("predict"));
        	weather.tod = parseString(entry.attr("tod"));
        	weather.weekday = parseString(entry.attr("weekday"));
        	
        	XmlDom phemomena = entry.child("PHENOMENA");
        	weather.cloudiness = parseString(phemomena.attr("cloudiness"));
        	weather.precipitation = parseString(phemomena.attr("precipitation"));
        	weather.rpower = parseString(phemomena.attr("rpower"));
        	weather.spower = parseString(phemomena.attr("spower"));
        	
        	XmlDom pressure = entry.child("PRESSURE");
        	weather.pressureMax = parseString(pressure.attr("max"));
        	weather.pressureMin = parseString(pressure.attr("min"));
        	
        	XmlDom temp = entry.child("TEMPERATURE");
        	weather.tempMax = parseString(temp.attr("max"));
        	weather.tempMin = parseString(temp.attr("min"));
        	
        	XmlDom wind = entry.child("WIND");
        	weather.windMax = parseString(wind.attr("max"));
        	weather.windMin = parseString(wind.attr("min"));
        	weather.direction = parseString(wind.attr("direction"));
        	
        	XmlDom relwet = entry.child("RELWET");
        	weather.relwetMax = parseString(relwet.attr("max"));
        	weather.relwetMin = parseString(relwet.attr("min"));
        	
        	XmlDom heat = entry.child("HEAT");
        	weather.heatMax = parseString(heat.attr("max"));
        	weather.heatMin = parseString(heat.attr("min"));
        	
        	days.add(weather);
        }
                
        //aq.id(R.id.image).image(imageUrl);
        Weater weather1 = days.get(1);
        Weater weather2 = days.get(2);
        Weater weather3 = days.get(3);
        
        tvGradus1.setText((weather1.tempMin+weather1.tempMax)/2 + "° C");
        tvGradus2.setText((weather2.tempMin+weather2.tempMax)/2 + "° C");
        tvGradus3.setText((weather3.tempMin+weather3.tempMax)/2 + "° C");
        
        tvDay1.setText("УТРО");
        tvDay2.setText("ДЕНЬ");
        tvDay3.setText("ВЕЧЕР");
        
        tvTime1.setText(getDayByDate(weather1.day));
        tvTime2.setText(getDayByDate(weather2.day));
        tvTime3.setText(getDayByDate(weather3.day));
        
        ivWether1.setImageResource(getResurseByWheater(weather1.precipitation, weather1.cloudiness));
        ivWether2.setImageResource(getResurseByWheater(weather2.precipitation, weather2.cloudiness));
        ivWether3.setImageResource(getResurseByWheater(weather3.precipitation, weather3.cloudiness));
        
        tvHumid1.setText((weather1.relwetMin+weather1.relwetMax)/2 + "%");
        tvHumid2.setText((weather2.relwetMin+weather2.relwetMax)/2 + "%");
        tvHumid3.setText((weather3.relwetMin+weather3.relwetMax)/2 + "%");
        
        tvRoza1.setText(windDir[weather1.direction]);
        tvRoza2.setText(windDir[weather2.direction]);
        tvRoza3.setText(windDir[weather3.direction]);
        
        tvRozaSpeed1.setText((weather1.windMin+weather1.windMax)/2 + " м/с");
        tvRozaSpeed2.setText((weather2.windMin+weather2.windMax)/2 + " м/с");
        tvRozaSpeed3.setText((weather3.windMin+weather3.windMax)/2 + " м/с");
        
        rotateToAngel(getAngel(weather1.direction), ivRoza1);
        rotateToAngel(getAngel(weather2.direction), ivRoza2);
        rotateToAngel(getAngel(weather3.direction), ivRoza3);
        
        Animation anim = AnimationUtils.loadAnimation(this, R.anim.grow_from_bottom_long);
        llContainer.startAnimation(anim);
        anim.setAnimationListener(new AnimationListener() {
			
			@Override
			public void onAnimationStart(Animation animation) {
				
			}
			
			@Override
			public void onAnimationRepeat(Animation animation) {
				
			}
			
			@Override
			public void onAnimationEnd(Animation animation) {
				llContainer.setVisibility(View.VISIBLE);
			}
		});
}

	private int getAngel(int direction) {
		switch (direction) {
		case 1:
			return 45;
			
		case 2:
			return 90;
			
		case 3:
			return 135;
			
		case 4:
			return 180;
			
		case 5:
			return -(135);
			
		case 6:
			return -90;
			
		case 7:
			return -45;
			
		default:
			return 0;
		}	
	}

	private void rotateToAngel(int angle, ImageView iv){
		//Matrix matrix=new Matrix();
		//iv.setScaleType(ScaleType.MATRIX);   //required
		//matrix.postRotate((float) angle, iv.getDrawable().getBounds().width()/2, iv.getDrawable().getBounds().height()/2);
		//iv.setImageMatrix(matrix);
		
		
		Bitmap myImg = BitmapFactory.decodeResource(getResources(), R.drawable.star);

		Matrix matrix = new Matrix();
		matrix.postRotate(angle);

		Bitmap rotated = Bitmap.createBitmap(myImg, 0, 0, myImg.getWidth(), myImg.getHeight(),
		        matrix, true);
		iv.setImageBitmap(rotated);
	}
	
	private int getResurseByWheater(int precipitation, int cloudiness) {

		if(precipitation == 9 || precipitation == 10)
		{
			if(cloudiness == 0)
				return R.drawable.weather_sun;
			else if(cloudiness == 3)
				return R.drawable.weather_cloudy;
			else
				return R.drawable.weather_party_cloudy;
		}
		else if(precipitation == 4 || precipitation == 5)
		{
			return R.drawable.weather_rain;
		}
		else if(precipitation == 6 || precipitation == 7)
		{
			return R.drawable.weather_snow;
		}
		else if(precipitation == 8)
		{
			return R.drawable.weather_storm;
		}
		return 0;
	}

	private String getDayByDate(int day) {
		Calendar c = Calendar.getInstance();
		int dayCurrent = c.get(Calendar.DAY_OF_MONTH);
		if (day == dayCurrent){
			return "Сегодня";
		}
		return "Завтра";
	}

	private int parseString(String s){
		int res = 0;
		try {
			res = Integer.parseInt(s);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return res;
	}
	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.image_view_link:
			break;

		default:
			break;
		}
	}

}
