<template>
  <div>
    <a-modal
      :visible="visible"
      :title="opType==='add'? '新增菜单' : '修改菜单'"
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
          <a-form-model-item label="父菜单" prop="parentId">
            <a-tree-select
              v-model="form.parentId"
              style="width: 100%"
              :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
              :tree-data="menuTree"
              :replaceFields="menuTreeReplaceFields"
              placeholder="选择父菜单"
              tree-default-expand-all
              allowClear
            >
            </a-tree-select>
          </a-form-model-item>
          <a-form-model-item label="名称" prop="title">
            <a-input v-model="form.title" />
          </a-form-model-item>
          <a-form-model-item label="权限" prop="permissions">
            <a-input v-model="form.permissions" />
          </a-form-model-item>
          <a-form-model-item label="Vue组件" prop="component">
            <a-input v-model="form.component" />
          </a-form-model-item>
          <a-form-model-item label="路径" prop="path">
            <a-input v-model="form.path" />
          </a-form-model-item>
          <a-form-model-item label="排序" prop="orderNum">
            <a-input-number v-model="form.orderNum" />
          </a-form-model-item>
          <a-form-model-item label="图标" prop="icon">
            <a-input v-model="form.icon" />
          </a-form-model-item>
          <a-form-model-item label="类型" prop="type">
            <a-radio-group v-model="form.type" name="type" :defaultValue="1">
              <a-radio :value="1">
                目录
              </a-radio>
              <a-radio :value="2">
                菜单
              </a-radio>
              <a-radio :value="3">
                权限
              </a-radio>
            </a-radio-group>
          </a-form-model-item>
        </a-form-model>
      </a-spin>
    </a-modal>
  </div>
</template>

<script>
  import { TreeSelect } from 'ant-design-vue'
  import { getNavTree } from '@/api/menu'
  const defaultForm = {
    title: ''
  }
  export default {
    name: 'Edit',
    components: {
      ATreeSelect: TreeSelect
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
            span: 18
          }
        },
        form: defaultForm,
        rules: {
          title: [
            { required: true, message: '名称不能为空', trigger: 'blur' }
          ]
        },
        menuTree: [],
        menuTreeReplaceFields: {
          title: 'title',
          key: 'menuId',
          value: 'menuId'
        }
      }
    },
    created () {
      this.fetchMenuTree()
    },
    methods: {
      fetchMenuTree () {
        getNavTree(false)
          .then(res => {
            this.menuTree = res.data
          })
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
        this.form.type = 1
        if (this.opType === 'update') {
          this.form = { ...this.fromData }
          const parentId = this.fromData.parentId
          if (parentId === '0') {
            this.form.parentId = undefined
          }
        }
      }
    }
  }
</script>
