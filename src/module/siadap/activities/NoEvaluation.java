package module.siadap.activities;

import module.siadap.domain.Siadap;
import module.siadap.domain.SiadapEvaluation;
import module.siadap.domain.SiadapProcess;
import module.workflow.activities.ActivityInformation;
import module.workflow.activities.WorkflowActivity;
import myorg.domain.User;

public class NoEvaluation extends WorkflowActivity<SiadapProcess, NoEvaluationActivityInformation> {

    @Override
    public boolean isActive(SiadapProcess process, User user) {
	Siadap siadap = process.getSiadap();
	return !siadap.isWithSkippedEvaluation() && !siadap.isEvaluationDone()
		&& siadap.getEvaluator().getPerson().getUser() == user && siadap.getValidated() == null
		&& siadap.getEvaluationInterval().containsNow();
    }

    @Override
    public ActivityInformation<SiadapProcess> getActivityInformation(SiadapProcess process) {
	return new NoEvaluationActivityInformation(process, this);
    }

    @Override
    protected void process(NoEvaluationActivityInformation activityInformation) {
	new SiadapEvaluation(activityInformation.getProcess().getSiadap(), activityInformation.getNoEvaluationJustification());
    }

    @Override
    public boolean isConfirmationNeeded(SiadapProcess process) {
	return true;
    }

    @Override
    public String getUsedBundle() {
	return "resources/SiadapResources";
    }
}