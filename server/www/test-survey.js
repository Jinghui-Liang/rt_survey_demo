// ------- Functions to set up database connection ----------

const getData = async (data, uri) => {
    const settings_get = {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    };
    try {
        const fetchOrder = await fetch(uri, settings_get);
        const data = await fetchOrder.json();
        return data;
    } catch (e) {
        console.log(e);
    }
};

const getOrder = async () => {
    let data = await getData({}, 'match_order.php');
    return data;
};

// --------- Setting up questionnaire. -------------
// import { start, blank, trials, show_data } from './que-6.js';
import { start, blank, trials, show_data } from './que-3.js';
console.log (trials);
// --------- Initializing jsPsych and posting response to database ----------

const postData = async (data, uri) => {
    const settings_post = {
	method: 'POST',
	headers: {
	    Accept: 'application/json',
	    'Content-Type': 'application/json'
	},
	body: JSON.stringify(data)
    };
    try {
	const fetchResponse = await fetch(uri, settings_post);
	const data = await fetchResponse.json();
	console.log (data);
	return data;
    } catch (e) {
	console.log(e);
    }
};

let promiseSuccess = (data) => {
    if (data.length == 0) {
	document.write ('all presentation orders are fully assigned, please run "Rscript reset_counter.R" in terminal to run this survey again');
	throw 'all presentation orders are fully assigned, please run "Rscript reset_counter.R" in terminal to run this survey again';
    } else {
    var order_label = Object.values (data[0]);
    let order = order_label.slice (1, order_label.length).map (x => x + 1);
    
    if (order.length < 10) {
	var order_str = order.map (i => "0" + i);
    } else {
	for (j; j <= order.length - 1; j++) {
	    let element = order[j];
	    if (element.length == 1) {
		temp = "0" + element;
		order_str.push (temp);
	    } else {
		order_str.push (order[j]);
	    }
	}
    };
    };

// use async function to get presentation order from mysql
    
var jsPsych = initJsPsych({
    on_finish: function () {
	var p_id = jsPsych.randomization.randomID(4);
	jsPsych.data.addProperties({order_index: method,
				    p_id: p_id});
	var match = {
	    p_id: p_id,
	    order_label: method
	};
	console.log (match);
	let json = jsPsych.data.get()
	    .filterCustom(trial => trial.trial_type == 'survey-likert')
	    .ignore('question_order');
	let json_trials = json.trials.map(x => {
	    let question = Object.keys(x.response)[0];
	    let response = x.response[question];
	    return ({
		p_id: x.p_id,
		rt: x.rt,
		response: x.response,
		Q_num: x.Q_num,
		trial_type: x.trial_type,
		trial_index: x.trial_index,
		order_index: x.order_index,
		time_elapsed: x.time_elapsed,
		internal_node_id: x.internal_node_id
	    })
	});
	document.write (json_trials[0]);
	console.log (json_trials[0]);
	let trial_data = {
	    json_trials: json_trials,
	    proc_method: 'insertLikertResp'
	};
	postData (match, 'postMatch.php');
	postData (trial_data, 'postData.php');
	console.log(JSON.stringify(trial_data));
    }
});

// ----------- Reorganize questions based on the given order. -------------
    
    var new_order = []; 
    var v = 0;
    var id = 0;
    console.log (trials[id].data);
    for (v; v < order_str.length; v++) {
	while (trials[id].data.Q_num != order_str[v]) {
	    id++;;
	}
	new_order.push (trials[id]);
	id = 0; // repeatly matching.
    };
    console.log (order_label);
    console.log (new_order);
    var method = order_label [0];
    var fin_order = {timeline: new_order};
    jsPsych.run([start, blank, fin_order, show_data]); 
};

var presOrder = getOrder();

presOrder.then(promiseSuccess, (err) => {
    console.log(error);
});
