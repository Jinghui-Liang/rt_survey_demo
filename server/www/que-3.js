// When specifying the Q-num, use strings "01" to "09" to match the presentation order.

var instru = `how you feel like you are a...`;
var likert = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"];
var trials = [];

var start = {
    type: jsPsychHtmlButtonResponse,
    stimulus: '<p>Welcome to this behaviour survey, please press "start" to continue</p>',
    choices: [`Start`],
    data: { Q_num: `start` }
};

var blank = {
    type: jsPsychHtmlButtonResponse,
    stimulus: 'Press "Start" again to begin the survey',
    choices: [`Start`],
    data: { Q_num: 0 }
};

var show_data = {
    type: jsPsychHtmlButtonResponse,
    stimulus: `that's the end of this survey,thanks for your participation.`,
    choices: ['Show results'],
    data: { Q_num: `drop` }
};

var Q1 = {
    type: jsPsychSurveyLikert,
    questions: [{
        prompt: "Q1.",
        labels: likert
    }],
    preamble: instru,
    data: { Q_num: `01`}
};

trials.push (Q1);

var Q2 = {
    type: jsPsychSurveyLikert,
    questions: [{
        prompt: "Q2.",
        labels: likert
    }],
    preamble: instru,
    data: { Q_num: `02`}
};

trials.push (Q2);

var Q3 = {
    type: jsPsychSurveyLikert,
    questions: [{
        prompt: "Q3.",
        labels: likert
    }],
    preamble: instru,
    data: { Q_num: `03`}
};

trials.push (Q3);

export { start, blank, trials, show_data };
