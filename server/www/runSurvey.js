// --------- Setting up questionnaire. -------------

// import { start, blank, submit_data } from './welcome.js';
import { trials, demos, start, blank, submit_data } from './jsscalegen.js';

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

// main function to receive presentation order and run the survey

var order_str = [];

let runSurvey = (data) => {
    if (data.length == 0) {
	      document.write ('all presentation orders are fully assigned, please run "Rscript reset_counter.R" in terminal to run this survey again');
	      throw 'all presentation orders are fully assigned, please run "Rscript reset_counter.R" in terminal to run this survey again';
    } else {
        console.log(Object.values (data[0]));
        var order_label = Object.values (data[0]);
        var method = order_label[0];
        // let order = order_label.slice (1, order_label.length).map (x => x + 1);
	let order = order_label.slice(1);
	// console.log(order.length);
        if (order.length < 10) {
	    // var order_str = order.map (i => "0" + i);
	    // order_str = order.map (i => "0" + i);
	    order_str = order;
        } else {
            // var order_str = [];
	    // for (let j = 0; j <= order.length - 1; j++) {
	    for (let j = 0; j < order.length; j++) {
	        //       let  element = order[j];
                // if (element.length == 1) {
                //     // temp = "0" + element;
		//     temp = element;
                //     order_str.push (temp);
                // } else {
                //     order_str.push (order[j]);
                // }
		order_str.push (order[j]);
	    }
        };
    };

    // get presentation order from mysql
    var jsPsych = initJsPsych({
        on_finish: function () {
	          var p_id = jsPsych.randomization.randomID(4);
	          jsPsych.data.addProperties({order_index: method,
				              p_id: p_id});
            let rawResult = jsPsych.data.get();
            console.log (rawResult);
            
            let demoInfo = rawResult
                .filterCustom(trial => trial.isDemo == true)
                .trials.map (x => {
                    let demoProperty = x.Q_num;
                    let demoValue = x.response['Q0'];
                    return ({
                        p_id: x.p_id,
                        property: demoProperty,
                        value: demoValue
                    })
                });
            console.log(demoInfo);

            let json = rawResult
	              .filterCustom(trial => trial.isDemo == false)
	              .ignore('question_order');
            
	          let json_trials = json.trials.map(x => {
	              let question = Object.keys(x.response)[0];
	              let response = x.response[question];
	              return ({
		                p_id: x.p_id,
		                rt: x.rt,
		                response: x.response['Q0'],
		                Q_num: x.Q_num,
		                trial_type: x.trial_type,
		                trial_index: x.trial_index,
		                order_index: x.order_index,
		                time_elapsed: x.time_elapsed,
		                internal_node_id: x.internal_node_id
	              })
	          });
	          console.log (json_trials);
	          let trial_data = {
	              json_trials: json_trials,
	              proc_method: 'insertLikertResp'
	          };
            let demo_data = {
	              json_trials: demoInfo,
	              proc_method: 'insertDemo'
	          };
            var match_data = {
	              p_id: p_id,
	              order_label: method
	          };
            postData (demo_data, 'postDemo.php');
	    postData (match_data, 'postMatch.php');
	    postData (trial_data, 'postData.php');
	    console.log('data succesfully submitted');
        }
    });

    // ----------- Reorganize questions based on the given order. -------------
    var new_order = [];
    console.log(order_str);
    var id = 0;
    for (let v = 0; v < order_str.length; v++) {
	      while (trials[id].data.Q_num != order_str[v]) {
	          id++;
	      };
	      new_order.push (trials[id]);
	      id = 0; // repeatly matching.
    };

    // connect all trials
    new_order.unshift(blank);
    console.log(new_order);
    var surveyBody = {timeline: demos.concat(new_order)};

    jsPsych.run([start, surveyBody, submit_data]);
};

var presOrder = getOrder();

presOrder.then(runSurvey, (err) => {
    console.log(error);
});
