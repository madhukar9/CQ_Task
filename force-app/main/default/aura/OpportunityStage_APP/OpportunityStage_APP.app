<aura:application extends="force:slds">
    <c:OpportunityStage_CMP  objName="Opportunity" objFields="['Name', 'AccountId', 'Account.Name', 'CloseDate', 'StageName', 'Amount']" kanbanPicklistField="StageName"/>
</aura:application>