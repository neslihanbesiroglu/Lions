trigger CaseOriginTrig on Case (before insert) {
CaseOriginHandler.handleNewCases(trigger.new);
}