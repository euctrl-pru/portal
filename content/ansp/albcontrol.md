---
title: "Albcontrol"
slug: albcontrol
---

ANS Provider - Albania.

See the relevant [leaflet][leaf] from [ACE2015].


[leaf]: ../Albcontrol_Albania_ACE_2015.pdf "ACE 2015 Benchmarking Report Factsheet: Albcontrol"

[ACE2015]: http://www.eurocontrol.int/publications/atm-cost-effectiveness-ace-2015-benchmarking-report-2016-2020-outlook "ACE 2015 Benchmarking Report"

<div id="ANSP_filter_div"></div>
<div id="MyEmbed_div">
<embed src="../Albcontrol_Albania_ACE_2015.pdf" type="application/pdf" width="100%" height="850pt">
</div>


<script
  type="text/javascript"
  src="https://www.gstatic.com/charts/loader.js">
</script>

<script type="text/javascript">
	var data;
	var MyDataWithoutIntermediatePanEuropeanSystems;
	var ANSP_Picker;
	var SelectedANSP = 'Albcontrol';
	
	google.load('visualization', '1.1', {'packages':['corechart', 'table', 'controls']});
	google.setOnLoadCallback(Initialisation);

	function Initialisation() {
		var query = new google.visualization.Query('https://docs.google.com/spreadsheets/d/1SzrRUcel3Kr-VEbgTIhxcqXULAriyvbiIeSNYUG36uE/edit?usp=sharing');
		query.send(drawDashboard);
	}

	function drawDashboard(response) {
		data = response.getDataTable();

		MyDataWithoutIntermediatePanEuropeanSystems = new google.visualization.DataView(data);
			MyDataWithoutIntermediatePanEuropeanSystems.setRows(data.getFilteredRows([{column: 1, test: function(value, row, column, table) {
				return (value.substring(0,3) != 'Pan')}}]));

		ANSP_Picker = new google.visualization.ControlWrapper({
			controlType: 'CategoryFilter',
			containerId: 'ANSP_filter_div',
			dataTable: MyDataWithoutIntermediatePanEuropeanSystems,
//			dataTable: data,
			state: {selectedValues: [SelectedANSP]},
			options: {
				filterColumnLabel: 'ANSP_NAME',
				ui: {
					label: 'Select ANSP:',
					caption: '',
//					labelStacking: 'vertical',
					allowTyping: false,
					allowMultiple: false,
					sortValues: true,
					allowNone: false,
//					cssClass: 'ClassANSPPicker',
				},
			}
		});
		ANSP_Picker.draw();
		google.visualization.events.addListener(ANSP_Picker, 'statechange', changeANSP_Picker);
	}
	
	function changeANSP_Picker () {
		SelectedANSP = ANSP_Picker.getState().selectedValues[0];
		document.getElementById("MyEmbed_div").innerHTML = '<embed src="../'+SelectedANSP+'.pdf" type="application/pdf" width="100%" height="850pt" />';
	}
</script>