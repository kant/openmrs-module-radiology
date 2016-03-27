<%@ include file="/WEB-INF/template/include.jsp"%>

<openmrs:require privilege="View Orders" otherwise="/login.htm"
	redirect="/module/radiology/radiologyOrderList.jsp" />


<c:if test="${not empty orderList}">
	<c:if test="${empty exceptionText}">
		<table id="matchedOrders" cellspacing="0" width="100%"
			class="display nowrap">
			<thead>
				<tr>
					<th></th>
					<th><spring:message code="general.edit" /></th>
					<th><spring:message code="radiology.patientId" /></th>
					<th><spring:message code="radiology.patientFullName" /></th>
					<th><spring:message code="radiology.priority" /></th>
					<th><spring:message code="radiology.appoinmentDate" /></th>
					<th><spring:message code="radiology.modality" /></th>
					<th><spring:message code="radiology.performedStatus" /></th>
					<th><spring:message code="radiology.referringPhysician" /></th>
					<th><spring:message code="radiology.scheduledStatus" /></th>
					<th><spring:message code="general.instructions" /></th>
					<th><spring:message code="radiology.mwlStatus" /></th>
				</tr>
			</thead>
			<tbody id="matchedOrdersBody">
				<c:forEach items="${orderList}" var="radiologyOrder">
					<tr data-child-order_id="${radiologyOrder.orderId}"
						data-child-physician="${radiologyOrder.orderer.name}"
						data-child-status="${radiologyOrder.study.scheduledStatus}"
						data-child-instructions="${radiologyOrder.instructions}"
						data-child-mwl="<spring:message code="radiology.${radiologyOrder.study.mwlStatus}"/>">
						<td class="details-control"></td>
						<td><a
							href="radiologyOrder.form?orderId=${radiologyOrder.orderId}">${radiologyOrder.orderId}</a></td>
						<td style="text-align: center">${radiologyOrder.patient.patientIdentifier}</td>
						<td>${radiologyOrder.patient.personName}</td>
						<td>${radiologyOrder.urgency}</td>
						<td name="appointmentDate">${radiologyOrder.effectiveStartDate}</td>
						<td>${radiologyOrder.study.modality.fullName}</td>
						<td>${radiologyOrder.study.performedStatus}</td>
						<td>${radiologyOrder.orderer.name}</td>
						<td>${radiologyOrder.study.scheduledStatus}</td>
						<td style="max-width: 90px; overflow: hidden;"><a
							style="cursor: pointer"
							onclick="$j('<p>'+this.innerHTML+'</p>').dialog({autoOpen:true,modal:true});"
							title="<spring:message code="general.view"/>">${radiologyOrder.instructions}
						</a></td>
						<td><spring:message code="radiology.${radiologyOrder.study.mwlStatus}"
								text="${radiologyOrder.study.mwlStatus}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</c:if>
<c:if test="${not empty exceptionText}">
	<span id="errorSpan" class="error"> <spring:message
			code="${exceptionText}" arguments="${invalidValue}" />
	</span>
</c:if>
<c:if test="${empty orderList}">
	<br />
	<p>
		<spring:message code="radiology.OrderListEmpty" />
	</p>
</c:if>
