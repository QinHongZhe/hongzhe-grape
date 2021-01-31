<template>
  <a-modal
    :visible="visible"
    :title="opType==='add'? '新增用户' : '修改用户'"
    :maskClosable="false"
    :width="640"
    :confirmLoading="loading"
    @ok="ok"
    @cancel="cancel"
    okText="确认"
    cancelText="取消"
  >
    <a-spin :spinning="loading">
      <a-form-model
        ref="ruleForm"
        :model="form"
        :rules="rules"
        :label-col="formLayout.labelCol"
        :wrapper-col="formLayout.wrapperCol"
      >
        <a-form-model-item label="角色">
          <a-select
            v-model="roleIds"
            placeholder="请选择角色"
            mode="multiple"
            notFoundContent="没有可以的角色"
            :showSearch="true"
            @change="handleChange">
            <a-select-option v-for="role in roles" :key="role.roleId">
              {{ role.name }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="名称" prop="name">
          <a-input v-model="form.name" />
        </a-form-model-item>
        <a-form-model-item label="用户名" prop="username">
          <a-input v-model="form.username" />
        </a-form-model-item>
        <a-form-model-item label="密码" prop="password" v-if="opType==='add'">
          <a-input type="password" v-model="form.password" />
        </a-form-model-item>
        <a-form-model-item label="状态" prop="status" v-if="opType==='add'">
          <a-radio-group v-model="form.status" name="status" defaultValue="1">
            <a-radio :value="1">
              启用
            </a-radio>
            <a-radio :value="0">
              禁用
            </a-radio>
          </a-radio-group>
        </a-form-model-item>
        <a-form-model-item label="手机号" prop="phone">
          <a-input v-model="form.phone" />
        </a-form-model-item>
        <a-form-model-item label="邮箱" prop="email">
          <a-input v-model="form.email" />
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
  import { FormModel } from 'ant-design-vue'
  import { getList } from '@/api/role'
  import { fetchResult } from '@/utils/fetchUtil'
  const defaultForm = {
    roleIds: [],
    status: 1
  }
  export default {
    name: 'EditModel',
    components: {
      FormModel
    },
    props: {
      visible: {
        type: Boolean,
        required: true,
        default: () => false
      },
      fromData: {
        type: Object,
        required: false,
        default: () => {}
      },
      opType: {
        type: String,
        required: false,
        default: () => null
      },
      loading: {
        type: Boolean,
        default: () => false
      }
    },
    created () {
      getList()
        .then(res => {
          this.roles = fetchResult(res, false)
        })
    },
    data () {
      return {
        formLayout: {
          labelCol: {
            span: 4
          },
          wrapperCol: {
            span: 14
          }
        },
        roles: {},
        form: defaultForm,
        roleIds: [],
        rules: {
          roleIds: [
            { required: true, message: '角色不能为空', trigger: 'blur' }
          ],
          name: [
            { required: true, message: '名称不能为空', trigger: 'blur' }
          ],
          username: [
            { required: true, message: '用户名不能为空', trigger: 'blur' },
            { max: 16, message: '用户名不能超过16位', trigger: 'blur' }
          ],
          password: [
            { required: true, message: '密码不能为空', trigger: 'blur' },
            { min: 6, message: '密码长度不能小于6位', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      handleChange (value) {
        this.roleIds = value
        this.form.roleIds = value
      },
      ok () {
        this.$refs.ruleForm.validate(valid => {
          if (valid) {
            this.$emit('ok', this.opType, { ...this.form })
            this.$refs.ruleForm.resetFields()
          } else {
            return false
          }
        })
      },
      cancel () {
        this.form = defaultForm
        this.$emit('cancel')
      }
    },
    watch: {
      fromData () {
        if (this.opType === 'update') {
          this.form = { ...this.fromData }
          const roleNames = this.fromData.roleNames
          this.roleIds = []
          if (roleNames) {
            this.roleIds = roleNames.split(',')
          } else {
            this.roleIds = []
          }
        }
      }
    }
  }
</script>
