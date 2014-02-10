package com.stexgroup.novinki;

import java.util.Calendar;

import com.stexgroup.novinki.R.color;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class WorkingTimeActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_working_time);
		ListView list = (ListView) findViewById(R.id.list_view_working_time);
		
		TimeAdapter adapter = new TimeAdapter(getBaseContext());
		adapter.add(new Day(getString(R.string.day1),11,23));
		adapter.add(new Day(getString(R.string.day2),11,23));
		adapter.add(new Day(getString(R.string.day3),11,23));
		adapter.add(new Day(getString(R.string.day4),11,23));
		adapter.add(new Day(getString(R.string.day5),11,23));
		adapter.add(new Day(getString(R.string.day6),9,23));
		adapter.add(new Day(getString(R.string.day7),9,21));
		
		list.setAdapter(adapter);
		
	}
	
	private class Day{
		public String name;
		public int startTime;
		public int closeTime;
		
		public Day (String name, int start, int close){
			this.name = name;
			this.startTime = start;
			this.closeTime = close;
		}
	}
	
	public class TimeAdapter extends ArrayAdapter<Day> {

		public TimeAdapter(Context context) {
			super(context, 0);
		}

		public View getView(final int position, View convertView, ViewGroup parent) {
			if (convertView == null) {
				convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_working_time, null);
			}
			TextView textDay = (TextView) convertView.findViewById(R.id.text_view_working_time_day);
			TextView textTime = (TextView) convertView.findViewById(R.id.text_view_working_time_time);
			
			textDay.setText(getItem(position).name);
			
			//String time = getString(R.string.working_time_string, getItem(position).startTime, getItem(position).closeTime);
			
			String time = getItem(position).startTime + "<sup><small>00</small></sup> - " + getItem(position).closeTime +"<sup><small>00</small></sup>";
			textTime.setText(Html.fromHtml(time));
			
			Calendar c = Calendar.getInstance();
			int day = c.get(Calendar.DAY_OF_WEEK);
			day = day - 2;
			if (day<0) day = 7 + day;
			
			if ( day == position){
				convertView.setBackgroundColor(getContext().getResources().getColor(R.color.working_day_selected));
				textDay.setTextColor(getContext().getResources().getColor(R.color.white));
				textTime.setTextColor(getContext().getResources().getColor(R.color.white));
			}
			
			return convertView;
		}

	}

}
