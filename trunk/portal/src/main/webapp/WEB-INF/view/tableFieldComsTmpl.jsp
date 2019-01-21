<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24 0024
  Time: 下午 4:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/html" id="editTableFieldComsTmpl">
    <div class="skin skin-minimal">
        <table class="table table-hover table-bordered">
            <thead>
            <tr>
                <th>字段名称</th>
                <th>注释</th>
            </tr>
            </thead>
            <tbody>
            {{each tableInfosList as tableInfos i }}
            {{each tableInfos.tableInfos as tableInfo i }}
            <tr>
                <td class="fieldComsKey" tableName="{{tableInfos.tableName}}" fieldName="{{tableInfo.columnName}}"
                    columnNameLabel="{{tableInfo.columnNameLabel}}" dataType="{{tableInfo.dataType}}">
                    {{if tableInfo.columnNameLabel}}
                    {{tableInfo.columnNameLabel}}{{else}}{{tableInfo.columnName}}{{/if}}
                </td>
                <td>
                    <input type="text" class="form-control  input-sm fieldComsValue" style="width: 60%"
                           name="order_customer_name" value="{{tableInfo.columnComment}}">
                </td>
            </tr>
            {{/each}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>

<script type="text/html" id="previewTableDataAndComsTmpl">
    <div class="skin skin-minimal">
        <table class="table table-hover table-bordered">
            {{each datas as itemList i}}
            {{if i == 0}}
            <thead>
            <tr style="word-break: keep-all">
                <th>#</th>
                {{each itemList as item j}}
                <th>{{item.columnName}}
                    {{if item.columnComment}}
                    <br/>({{item.columnComment}})
                    {{/if}}
                </th>
                {{/each}}
            </tr>
            </thead>
            {{/if}}
            <tbody>
            {{if i != 0}}
            <tr>
                <td>{{i}}</td>
                {{each itemList as item j}}
                <td>{{item}}</td>
                {{/each}}
            </tr>
            {{/if}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>



<script type="text/html" id="tableNameLi">
        {{each data as value i}}
        {{each value as v key}}
            {{if i == 0}}
            <li class="active">
                <a href={{"#"+key}} data-toggle="tab" aria-expanded="true"> {{key}} </a>
            </li>
            {{else}}
            <li>
                <a href={{"#"+key}} data-toggle="tab"> {{key}} </a>
            </li>
            {{/if}}
        {{/each}}
    {{/each}}
</script>

<script type="text/html" id="tableNameDiv">
    {{each data as value i}}
        {{each value as v key}}
            {{if i== 0}}
            <div class="tab-pane active" >
                <form id={{key}}></form>
            </div>
            {{else}}
            <div class="tab-pane">
                <form id={{key}}></form>
            </div>
            {{/if}}
        {{/each}}
    {{/each}}
</script>

<script type="text/html" id="tableFieldIsExist">
    <div class="tab-pane">
        <table class="table table-hover table-bordered">
            <thead>
            <tr style="word-break: keep-all">
                <th>表中字段名称</th>
                <th>表中字段注释</th>
                <th>excel字段名称</th>
                <th>excel字段注释</th>
                <th>是否主键</th>
            </tr>
            </thead>
            <tbody>
            {{each data as v i}}
            {{if i > 0 && v[0] !="PORTALID"}}
            <tr>
                {{each v as vv ii}}
                {{if ii == 0 || ii == 1}}
                <td>
                    {{vv}}
                </td>
                {{/if}}
                {{/each}}


                <td>
                    <select>
                        <option  value="-1">不匹配任何字段</option>
                        {{each data as vd id}}
                        {{if id > 0 && vd[3] != ""}}
                                {{if id == i}}
                                <option selected="selected" value={{vd[3]}}>{{vd[3]}}</option>
                                {{else}}
                                <option value={{vd[3]}}>{{vd[3]}}</option>
                                {{/if}}
                            {{/if}}
                        {{/each}}
                    </select>
                </td>


                {{each v as vv ii}}
                {{if ii == 4}}
                <td>{{vv}}</td>
                {{/if}}
                {{/each}}

                {{if v[2] == "PRI"}}
                <td><input type="radio" name="isPK" fieldPk={{v[0]}} checked disabled/></td>
                {{else }}
                <td><input type="radio" name="isPK"  disabled/></td>
                {{/if}}
            </tr>
            {{/if}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>

<script type="text/html" id="tableFieldNotExist">
    <div class="tab-pane">
        <table class="table table-hover table-bordered">
            <thead>
            <tr style="word-break: keep-all">
                <th>序号</th>
                <th>excel字段名称</th>
                <th>excel字段注释</th>
                <th>字段类型</th>
                <th>字段长度</th>
                <th>
                    是否主键
                    <button id="clearPK" class="btn btn-default" type="button">清除</button>
                </th>
            </tr>
            </thead>
            <tbody>
            {{each data as v i}}
            {{if i > 0}}
            <tr>
                <td>{{i}}</td>

                {{each v as vv ii}}
                {{if ii > 2}}
                <td>
                    <input name={{vv}} value={{vv}} />
                </td>
                {{/if}}
                {{/each}}

                <td>
                    <select fieldType={{v[0]}}>
                        <option value="0" selected>请选择字段类型</option>
                        <option value="varchar">varchar</option>
                        <option value="int">int</option>
                        <option value="text">text</option>
                    </select>
                </td>

                <td>
                    <input placeholder="请输入字段长度" fieldLength={{v[0]}} />
                </td>
                <td><input type="radio" name="isPK" fieldPk={{v[0]}} /></td>
            </tr>
            {{/if}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>
