/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.hr.model;

import java.io.Serializable;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * This class is used by SOAP remote services.
 *
 * @author    Wesley Gong
 * @generated
 */
public class HRExpenseCurrencySoap implements Serializable {
	public static HRExpenseCurrencySoap toSoapModel(HRExpenseCurrency model) {
		HRExpenseCurrencySoap soapModel = new HRExpenseCurrencySoap();

		soapModel.setHrExpenseCurrencyId(model.getHrExpenseCurrencyId());
		soapModel.setGroupId(model.getGroupId());
		soapModel.setCompanyId(model.getCompanyId());
		soapModel.setUserId(model.getUserId());
		soapModel.setUserName(model.getUserName());
		soapModel.setCreateDate(model.getCreateDate());
		soapModel.setModifiedDate(model.getModifiedDate());
		soapModel.setCode(model.getCode());
		soapModel.setName(model.getName());
		soapModel.setDescription(model.getDescription());

		return soapModel;
	}

	public static HRExpenseCurrencySoap[] toSoapModels(
		HRExpenseCurrency[] models) {
		HRExpenseCurrencySoap[] soapModels = new HRExpenseCurrencySoap[models.length];

		for (int i = 0; i < models.length; i++) {
			soapModels[i] = toSoapModel(models[i]);
		}

		return soapModels;
	}

	public static HRExpenseCurrencySoap[][] toSoapModels(
		HRExpenseCurrency[][] models) {
		HRExpenseCurrencySoap[][] soapModels = null;

		if (models.length > 0) {
			soapModels = new HRExpenseCurrencySoap[models.length][models[0].length];
		}
		else {
			soapModels = new HRExpenseCurrencySoap[0][0];
		}

		for (int i = 0; i < models.length; i++) {
			soapModels[i] = toSoapModels(models[i]);
		}

		return soapModels;
	}

	public static HRExpenseCurrencySoap[] toSoapModels(
		List<HRExpenseCurrency> models) {
		List<HRExpenseCurrencySoap> soapModels = new ArrayList<HRExpenseCurrencySoap>(models.size());

		for (HRExpenseCurrency model : models) {
			soapModels.add(toSoapModel(model));
		}

		return soapModels.toArray(new HRExpenseCurrencySoap[soapModels.size()]);
	}

	public HRExpenseCurrencySoap() {
	}

	public long getPrimaryKey() {
		return _hrExpenseCurrencyId;
	}

	public void setPrimaryKey(long pk) {
		setHrExpenseCurrencyId(pk);
	}

	public long getHrExpenseCurrencyId() {
		return _hrExpenseCurrencyId;
	}

	public void setHrExpenseCurrencyId(long hrExpenseCurrencyId) {
		_hrExpenseCurrencyId = hrExpenseCurrencyId;
	}

	public long getGroupId() {
		return _groupId;
	}

	public void setGroupId(long groupId) {
		_groupId = groupId;
	}

	public long getCompanyId() {
		return _companyId;
	}

	public void setCompanyId(long companyId) {
		_companyId = companyId;
	}

	public long getUserId() {
		return _userId;
	}

	public void setUserId(long userId) {
		_userId = userId;
	}

	public String getUserName() {
		return _userName;
	}

	public void setUserName(String userName) {
		_userName = userName;
	}

	public Date getCreateDate() {
		return _createDate;
	}

	public void setCreateDate(Date createDate) {
		_createDate = createDate;
	}

	public Date getModifiedDate() {
		return _modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		_modifiedDate = modifiedDate;
	}

	public String getCode() {
		return _code;
	}

	public void setCode(String code) {
		_code = code;
	}

	public String getName() {
		return _name;
	}

	public void setName(String name) {
		_name = name;
	}

	public String getDescription() {
		return _description;
	}

	public void setDescription(String description) {
		_description = description;
	}

	private long _hrExpenseCurrencyId;
	private long _groupId;
	private long _companyId;
	private long _userId;
	private String _userName;
	private Date _createDate;
	private Date _modifiedDate;
	private String _code;
	private String _name;
	private String _description;
}