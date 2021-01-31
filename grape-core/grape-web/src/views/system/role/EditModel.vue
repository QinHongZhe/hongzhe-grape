<template>
  <a-modal
    :visible="visible"
    :title="opType==='add'? '新增角色' : '修改角色'"
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
        <a-form-model-item label="名称" prop="name">
          <a-input v-model="form.name" />
        </a-form-model-item>
        <a-form-model-item label="编号" prop="code">
          <a-input v-model="form.code" />
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
        <a-form-model-item label="描述" prop="description">
          <a-input v-model="form.description" type="textarea" />
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
  import { FormModel } from 'ant-design-vue'
  const defaultForm = {
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
        form: defaultForm,
        rules: {
          name: [
            { required: true, message: '名称不能为空', trigger: 'blur' }
          ],
          code: [
            { required: true, message: '编号不能为空', trigger: 'blur' },
            { max: 16, message: '编号不能超过16位', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
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
        }
      }
    }
  }
</script>
